# ----
# DATA
# ----

data "aws_route53_zone" "cert_manager" {
  name = local.k8s_cert_manager.route53_zone_id
}

data "aws_eks_cluster" "cert_manager" {
  name = local.eks_cluster.name
}
