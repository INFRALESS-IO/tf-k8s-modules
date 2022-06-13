# ------
# LOCALS
# ------

locals {
  eks_cluster = {
    name = var.eks_cluster_name
  }
  k8s_cert_manager = {
    version         = "v1.8.0"
    route53_zone_id = var.app_domain_name
  }
}
