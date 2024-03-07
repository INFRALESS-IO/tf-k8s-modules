# ----
# MAIN
# ----
# LIST OF RANCHER CHARTS https://charts.rancher.io/index.yaml

# RANCHER MONITORING GRAFANA / PROMETHEUS COMPONENTS

resource "helm_release" "rancher_monitoring_crd" {
  name             = "rancher-monitoring-crd"
  repository       = "https://charts.rancher.io"
  chart            = "rancher-monitoring-crd"
  version          = "103.0.0+up1.18.2"
  namespace        = "cattle-monitoring-system"
  create_namespace = true
  replace          = true
}

resource "helm_release" "rancher_monitoring" {
  name             = "rancher-monitoring"
  repository       = "https://charts.rancher.io"
  chart            = "rancher-monitoring"
  version          = "103.0.0+up1.18.2"
  namespace        = "cattle-monitoring-system"
  create_namespace = true
  replace          = true
  depends_on       = [helm_release.rancher_monitoring_crd]
}


