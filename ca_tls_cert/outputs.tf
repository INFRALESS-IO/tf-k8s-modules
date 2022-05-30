# ------------------------------------------------

output "aws_acm_certificate_arn" {
  value = aws_acm_certificate.this.arn
}

output "private_tls_cert" {
  value = tls_locally_signed_cert.cert.cert_pem
}

output "private_tls_key" {
  value = tls_private_key.cert.private_key_pem
}

output "private_tls_ca_cert" {
  value = tls_self_signed_cert.ca.cert_pem
}
