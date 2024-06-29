# ----
# MAIN
# ----

resource "helm_release" "teleport_cluster" {
  name       = "teleport"
  repository = "${path.module}/charts"
  chart      = "teleport-cluster"
  # version          = "7"
  namespace        = "teleport"
  create_namespace = true
  wait             = true
  values = [
    templatefile("${path.module}/files/teleport-cluster/custom-values.yaml", { ACME_EMAIL = "${try(local.acme_email, "")}", CLUSTER_NAME = "secure.${try(local.root_domain, "")}", PREFIX = "${local.prefix}", IMAGE = "${local.image}", IMAGE_TAG = "${local.image_tag}" })
  ]
}

resource "kubernetes_service" "teleport_cluster" {
  metadata {
    name      = "teleport-cluster-nlb"
    namespace = "teleport"
    annotations = {
      "service.beta.kubernetes.io/aws-load-balancer-backend-protocol" = "tcp"
      #"service.beta.kubernetes.io/aws-load-balancer-ssl-cert"         = var.certificate_arn
      "service.beta.kubernetes.io/aws-load-balancer-ssl-ports" = "443"
      "service.beta.kubernetes.io/aws-load-balancer-type"      = "nlb"
      "service.beta.kubernetes.io/aws-load-balancer-scheme"    = "internet-facing"
    }
  }
  spec {
    selector = {
      app = "teleport"
    }
    external_traffic_policy = "Cluster"
    port {
      name        = "https"
      port        = 443
      target_port = 3080
    }
    port {
      name        = "sshproxy"
      port        = 3023
      target_port = 3023
    }
    port {
      name        = "k8s"
      port        = 3026
      target_port = 3026
    }
    port {
      name        = "sshtun"
      port        = 3024
      target_port = 3024
    }
    port {
      name        = "mysql"
      port        = 3036
      target_port = 3036
    }
    type = "LoadBalancer"
  }
  lifecycle {
    ignore_changes = [
      metadata
    ]
  }
  depends_on = [helm_release.teleport_cluster]
}

# data "kubernetes_service" "ingress_teleport" {
#   metadata {
#     name = "teleport"
#     namespace = resource.helm_release[0].teleport_cluster.namespace
#   }
# }

# output "k8s_service_ingress" {
#   description   = "External DN name of load balancer"
#   value         = data.kubernetes_service.ingress_teleport.status.0.load_balancer.0.ingress.0.hostname
# }
