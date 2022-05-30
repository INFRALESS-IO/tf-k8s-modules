# ------
# LOCALS
# ------

locals {
  rancher_istio = {
    service_type            = "LoadBalancer"
    external_traffic_policy = "Local"
  }
  aws_acm_certificate_global = {
    arn = var.aws_acm_certificate_global_arn
  }
  vpc = {
    id             = var.vpc_id
    public_subnets = "public"
  }
}
