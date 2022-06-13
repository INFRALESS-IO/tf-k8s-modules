# -------
# OUTPUTS
# -------

output "teleport_cluster_nlb_endpoint" {
  value = kubernetes_service.teleport_cluster.status.0.load_balancer.0.ingress.0.hostname
}
