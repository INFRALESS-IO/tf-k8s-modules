# ----
# MAIN
# ----

resource "helm_release" "istio_tls" {
  name             = "istio-tls"
  repository       = "${path.module}/charts"
  chart            = "istio-tls"
  version          = local.k8s_istio_tls.version
  namespace        = "istio-system"
  create_namespace = true
  # force_update     = false
  # recreate_pods    = true
  # reset_values     = true
  values = [
    yamlencode({
      email = local.letsencrypt.email
      dns = {
        hostedZoneID = data.aws_route53_zone.istio_tls.zone_id
        commonName   = "*.${local.k8s_istio_tls.route53_zone_id}"
        dnsNames     = "*.${local.k8s_istio_tls.route53_zone_id}"
      },
      aws = {
        region = local.k8s_istio_tls.region
      },
      sample_app1 = {
        dnsNames = "sample-app1.${local.k8s_istio_tls.route53_zone_id}"
      }
    })
  ]
}
