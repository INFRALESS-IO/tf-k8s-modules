# ----
# MAIN
# ----
# LIST OF RANCHER CHARTS https://charts.rancher.io/index.yaml

# RANCHER MONITORING GRAFANA / PROMETHEUS COMPONENTS

resource "helm_release" "rancher_monitoring_crd" {
  name             = "rancher-monitoring-crd"
  repository       = "https://charts.rancher.io"
  chart            = "rancher-monitoring-crd"
  version          = "100.1.0+up19.0.3"
  namespace        = "cattle-monitoring-system"
  create_namespace = true
  replace          = true
}

resource "helm_release" "rancher_monitoring" {
  name             = "rancher-monitoring"
  repository       = "https://charts.rancher.io"
  chart            = "rancher-monitoring"
  version          = "100.1.0+up19.0.3"
  namespace        = "cattle-monitoring-system"
  create_namespace = true
  replace          = true
  depends_on       = [helm_release.rancher_monitoring_crd]
}


