# ----
# MAIN
# ----
# LIST OF RANCHER CHARTS https://charts.rancher.io/index.yaml

# RANCHER ISTIO / KIALI

resource "helm_release" "rancher_kiali_server_crd" {
  name             = "rancher-kiali-server-crd"
  repository       = "https://charts.rancher.io"
  chart            = "rancher-kiali-server-crd"
  version          = "100.0.0+up1.35.0"
  namespace        = "istio-system"
  create_namespace = true
  replace          = true
}

# https://stackoverflow.com/questions/64696721/how-do-i-pass-variables-to-a-yaml-file-in-heml-tf
resource "helm_release" "rancher_istio" {
  name             = "rancher-istio"
  repository       = "https://charts.rancher.io"
  chart            = "rancher-istio"
  version          = "100.0.0+up1.10.4"
  namespace        = "istio-system"
  create_namespace = true
  replace          = true
  # force_update     = true
  #recreate_pods    = true
  #reset_values     = true
  values = [
    templatefile("${path.module}/files/istio-values.values", { SERVICE_TYPE = "${local.rancher_istio.service_type}", EXTERNAL_TRAFFIC_POLICY = "${local.rancher_istio.external_traffic_policy}", AWS_ACM_CERTIFICATE_GLOBAL_ARN = "${local.aws_acm_certificate_global.arn}", SUBNET_IDS = "${sort(data.aws_subnet_ids.web_subnets.ids)[0]}, ${sort(data.aws_subnet_ids.web_subnets.ids)[1]}" })
  ]
  depends_on = [helm_release.rancher_kiali_server_crd]
}

#SETUP DEFAULT NAMESPACES AND INJECT ISTIO
resource "kubernetes_namespace" "private" {
  metadata {
    annotations = {
      name = "private"
    }
    labels = {
      istio-injection = "enabled"
    }
    name = "private"
  }
  lifecycle {
    ignore_changes = all
  }
  depends_on = [helm_release.rancher_istio]
}

resource "kubernetes_namespace" "public" {
  metadata {
    annotations = {
      name = "public"
    }
    labels = {
      istio-injection = "enabled"
    }
    name = "public"
  }
  lifecycle {
    ignore_changes = all
  }
  depends_on = [helm_release.rancher_istio]
}

resource "kubernetes_namespace" "secure" {
  metadata {
    annotations = {
      name = "secure"
    }
    labels = {
      istio-injection = "enabled"
    }
    name = "secure"
  }
  lifecycle {
    ignore_changes = all
  }
}
