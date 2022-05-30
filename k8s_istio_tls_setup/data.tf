# ----
# DATA
# ----

data "aws_route53_zone" "istio_tls" {
  name = local.k8s_istio_tls.route53_zone_id
}
