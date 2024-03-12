# ----
# MAIN
# ----

resource "kubernetes_namespace" "cattle_system" {
  metadata {
    annotations = {
      name = "cattle-system"
    }
    name = "cattle-system"
  }
  lifecycle {
    ignore_changes = [
      metadata
    ]
  }
}

resource "kubernetes_secret" "tls-secret" {
  type = "kubernetes.io/tls"
  metadata {
    name      = "tls-rancher-ingress"
    namespace = "cattle-system"
  }
  data = {
    "tls.crt" = local.rancher.private_tls_cert
    "tls.key" = local.rancher.private_tls_key
  }
  lifecycle {
    ignore_changes = [
      metadata
    ]
  }
}

resource "kubernetes_secret" "tls-ca" {
  metadata {
    name      = "tls-ca"
    namespace = "cattle-system"
  }
  data = {
    "cacerts.pem" = local.rancher.private_tls_ca_cert
  }
  lifecycle {
    ignore_changes = [
      metadata
    ]
  }
}

resource "helm_release" "rancher" {
  name             = "rancher"
  chart            = "https://releases.rancher.com/server-charts/latest/rancher-${var.rancher_version}.tgz"
  namespace        = "cattle-system"
  create_namespace = false
  wait             = true
  values = [
    templatefile("${path.module}/files/rancher.yml", { rancher_hostname = var.rancher_hostname, letsencrypt_email = var.letsencrypt_email })
  ]
  depends_on = [kubernetes_secret.tls-secret]
}


resource "kubernetes_service" "rancher" {
  metadata {
    name      = "rancher-internal-nlb"
    namespace = "cattle-system"
    annotations = {
      "service.beta.kubernetes.io/aws-load-balancer-backend-protocol"        = "ssl"
      "service.beta.kubernetes.io/aws-load-balancer-ssl-cert"                = var.rancher_certificate_arn
      "service.beta.kubernetes.io/aws-load-balancer-ssl-ports"               = "443"
      "service.beta.kubernetes.io/aws-load-balancer-type"                    = "nlb"
      "service.beta.kubernetes.io/aws-load-balancer-internal"                = "true"
      "service.beta.kubernetes.io/aws-load-balancer-target-group-attributes" = "preserve_client_ip.enabled=false"
    }
  }
  spec {
    selector = {
      app = "rancher"
    }
    //session_affinity = "ClientIP"
    external_traffic_policy = "Cluster"
    port {
      port        = 443
      target_port = 443
    }
    type = "LoadBalancer"
  }
  lifecycle {
    ignore_changes = [
      metadata
    ]
  }
  depends_on = [helm_release.rancher]
}

resource "kubernetes_service" "rancher2" {
  count = var.public_access ? 1 : 0
  metadata {
    name      = "rancher-external-nlb"
    namespace = "cattle-system"
    annotations = {
      "service.beta.kubernetes.io/aws-load-balancer-backend-protocol" = "ssl"
      "service.beta.kubernetes.io/aws-load-balancer-ssl-cert"         = var.rancher_certificate_arn
      "service.beta.kubernetes.io/aws-load-balancer-ssl-ports"        = "443"
      "service.beta.kubernetes.io/aws-load-balancer-type"             = "nlb"
      "service.beta.kubernetes.io/aws-load-balancer-scheme"           = "internet-facing"
    }
  }
  spec {
    selector = {
      app = "rancher"
    }
    external_traffic_policy = "Cluster"
    port {
      port        = 443
      target_port = 443
    }
    type = "LoadBalancer"
  }
  depends_on = [helm_release.rancher]
}
