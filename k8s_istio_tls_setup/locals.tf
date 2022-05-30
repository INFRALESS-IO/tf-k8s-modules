# ------
# LOCALS
# ------

locals {
  k8s_istio_tls = {
    version         = "1.0.5"
    route53_zone_id = var.app_domain_name
    region          = var.aws_region
  }
  aws = {
    region = var.aws_region
  }
  letsencrypt = {
    email = "mail@domain.app"
  }
}
