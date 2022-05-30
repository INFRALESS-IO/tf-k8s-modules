# ------
# LOCALS
# ------

locals {
  global = {
    prefix = var.prefix
  }
  aws = {
    region   = var.aws_region
    profile  = var.aws_profile
    vpc_id   = var.vpc_id
    role_arn = var.aws_role_arn
  }
  eks_cluster = {
    name                       = var.eks_cluster_name
    oidc_provider_url          = replace(var.eks_cluster_oidc_provider_url, "https://", "")
    endpoint                   = var.eks_cluster_endpoint
    certificate_authority_data = var.eks_cluster_certificate_authority_data
  }
  rancher = {
    private_tls_cert    = var.rancher_private_tls_cert
    private_tls_key     = var.rancher_private_tls_key
    private_tls_ca_cert = var.rancher_private_tls_ca_cert
  }
  k8s_cert_manager = {
    version = "v1.0.4"
  }
  aws_acm_certificate = {
    domain_names = var.acm_domain_name
  }
}
