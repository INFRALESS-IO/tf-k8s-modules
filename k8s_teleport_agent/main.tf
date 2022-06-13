# ----
# MAIN
# ----

resource "helm_release" "teleport_agent" {
  name       = "teleport"
  repository = "${path.module}/charts"
  chart      = "teleport-agent"
  # version          = "7"
  namespace        = "teleport"
  create_namespace = true
  wait             = true
  values = [
    templatefile("${path.module}/files/teleport-agent/custom-values.yaml", { AUTH_TOKEN = "${try(local.auth_token, "")}", PROXY_ADDR = "${try(local.proxy_addr, "")}", NODE_NAME = "${local.node_name}", ENV_NAME = "${local.env_name}" })
  ]
}
