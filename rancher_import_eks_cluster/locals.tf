# ------
# LOCALS
# ------

locals {
  rancher = {
    domain = var.rancher_domain
  }
  aws = {
    region = var.aws_region
  }
  iam = {
    secret_key = var.iam_secret_key
    access_key = var.iam_access_key
  }
  eks_cluster = {
    name = var.cluster_name
  }
}
