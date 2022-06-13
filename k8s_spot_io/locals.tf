# ------
# LOCALS
# ------

locals {
  aws_region           = var.aws_region
  eks_cluster_name     = var.eks_cluster_name
  account_id           = var.account_id
  token                = var.token
  virtual_node_groups  = var.virtual_node_groups
  private_subnets_ids  = var.private_subnets_ids
  secure_subnets_ids   = var.secure_subnets_ids
  image_id             = var.image_id
  user_data            = var.user_data
  security_groups      = var.security_groups
  iam_instance_profile = var.iam_instance_profile
  key_name             = var.key_name
}
