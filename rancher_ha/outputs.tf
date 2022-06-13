# -------
# OUTPUTS
# -------

output "rancher_nlb_endpoint" {
  value = kubernetes_service.rancher.status.0.load_balancer.0.ingress.0.hostname
}

output "rancher_nlb_endpoint2" {
  value = var.public_access ? kubernetes_service.rancher2[0].status.0.load_balancer.0.ingress.0.hostname : ""
}
