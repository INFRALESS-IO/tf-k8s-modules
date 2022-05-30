# ----
# MAIN
# ----

resource "rancher2_cloud_credential" "eks_cluster" {
  name        = local.eks_cluster.name
  description = local.eks_cluster.name
  amazonec2_credential_config {
    access_key = local.iam.access_key
    secret_key = local.iam.secret_key
  }
}

resource "rancher2_cluster" "eks_cluster" {
  name        = local.eks_cluster.name
  description = "Terraform EKS cluster"
  eks_config_v2 {
    cloud_credential_id = rancher2_cloud_credential.eks_cluster.id
    name                = local.eks_cluster.name
    region              = local.aws.region
    imported            = true
    private_access      = true
    public_access       = false
  }
  lifecycle {
    ignore_changes = all
  }
}

resource "time_sleep" "rancher2_cluster" {
  create_duration = "120s"
  triggers = {
    # This sets up a proper dependency
    rancher2_cluter_import_name = rancher2_cluster.eks_cluster.name
    rancher2_cluter_import_id   = rancher2_cluster.eks_cluster.id
  }
}
