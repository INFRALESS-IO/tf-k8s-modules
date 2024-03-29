# ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

resource "tls_private_key" "ca" {
  algorithm   = var.private_key_algorithm
  ecdsa_curve = var.private_key_ecdsa_curve
  rsa_bits    = var.private_key_rsa_bits
}

resource "tls_self_signed_cert" "ca" {
  #key_algorithm     = tls_private_key.ca.algorithm
  private_key_pem   = tls_private_key.ca.private_key_pem
  is_ca_certificate = true

  validity_period_hours = var.validity_period_hours
  allowed_uses          = var.ca_allowed_uses

  subject {
    common_name  = var.ca_common_name
    organization = var.organization_name
  }

}

resource "aws_ssm_parameter" "self_signed_cert_ca" {
  name  = "/eks/rancher/${var.cluster_name}/self_signed_cert_ca"
  type  = "SecureString"
  value = tls_self_signed_cert.ca.cert_pem
}

# ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

resource "tls_private_key" "cert" {
  algorithm   = var.private_key_algorithm
  ecdsa_curve = var.private_key_ecdsa_curve
  rsa_bits    = var.private_key_rsa_bits
}

resource "aws_ssm_parameter" "private_key" {
  name  = "/eks/rancher/${var.cluster_name}/private_key"
  type  = "SecureString"
  value = tls_private_key.cert.private_key_pem
}

resource "tls_cert_request" "cert" {
  #key_algorithm   = tls_private_key.cert.algorithm
  private_key_pem = tls_private_key.cert.private_key_pem

  dns_names    = var.dns_names
  ip_addresses = var.ip_addresses

  subject {
    common_name  = var.common_name
    organization = var.organization_name
  }
}

resource "tls_locally_signed_cert" "cert" {
  cert_request_pem = tls_cert_request.cert.cert_request_pem

  #ca_key_algorithm   = tls_private_key.ca.algorithm
  ca_private_key_pem = tls_private_key.ca.private_key_pem
  ca_cert_pem        = tls_self_signed_cert.ca.cert_pem

  validity_period_hours = var.validity_period_hours
  allowed_uses          = var.allowed_uses
}

resource "aws_ssm_parameter" "public_key" {
  name  = "/eks/rancher/${var.cluster_name}/public_key"
  type  = "SecureString"
  value = tls_locally_signed_cert.cert.cert_pem
}

resource "aws_acm_certificate" "this" {
  private_key       = tls_private_key.cert.private_key_pem
  certificate_body  = tls_locally_signed_cert.cert.cert_pem
  certificate_chain = "${tls_self_signed_cert.ca.cert_pem}${tls_locally_signed_cert.cert.cert_pem}"
}
