# ----
# MAIN
# ----

resource "spotinst_ocean_aws" "this" {
  region        = local.aws_region
  name          = local.eks_cluster_name
  controller_id = local.eks_cluster_name
  autoscaler {
    resource_limits {
      max_vcpu       = 100000
      max_memory_gib = 20000
    }
  }
  subnet_ids           = local.private_subnets_ids
  image_id             = local.image_id
  user_data            = local.user_data
  security_groups      = local.security_groups
  iam_instance_profile = local.iam_instance_profile
  key_name             = local.key_name

  tags {
    key   = "eks:cluster-name"
    value = local.eks_cluster_name
  }

  tags {
    key   = "k8s.io/cluster-autoscaler/enabled"
    value = "true"
  }

  tags {
    key   = "k8s.io/cluster-autoscaler/${local.eks_cluster_name}"
    value = "owned"
  }

  tags {
    key   = "kubernetes.io/cluster/${local.eks_cluster_name}"
    value = "owned"
  }
}

resource "spotinst_ocean_aws_launch_spec" "private" {
  count                = try(length(local.virtual_node_groups.private), 0)
  name                 = local.virtual_node_groups.private[count.index].name
  ocean_id             = spotinst_ocean_aws.this.id
  image_id             = local.image_id
  user_data            = local.user_data
  security_groups      = local.security_groups
  iam_instance_profile = local.iam_instance_profile
  subnet_ids           = local.private_subnets_ids
  root_volume_size     = local.virtual_node_groups.private[count.index].root_volume_size
  labels {
    key   = "spot-group"
    value = local.virtual_node_groups.private[count.index].name
  }
}

resource "spotinst_ocean_aws_launch_spec" "secure" {
  count                = try(length(local.virtual_node_groups.secure), 0)
  name                 = local.virtual_node_groups.secure[count.index].name
  ocean_id             = spotinst_ocean_aws.this.id
  image_id             = local.image_id
  user_data            = local.user_data
  security_groups      = local.security_groups
  iam_instance_profile = local.iam_instance_profile
  subnet_ids           = local.secure_subnets_ids
  root_volume_size     = local.virtual_node_groups.secure[count.index].root_volume_size
  labels {
    key   = "spot-group"
    value = local.virtual_node_groups.secure[count.index].name
  }
}

resource "helm_release" "spot_io" {
  name             = "spotinst-kubernetes-cluster-controller"
  repository       = "https://spotinst.github.io/spotinst-kubernetes-helm-charts"
  chart            = "spotinst-kubernetes-cluster-controller"
  namespace        = "kube-system"
  create_namespace = true

  set {
    name  = "spotinst.token"
    value = local.token
  }

  set {
    name  = "spotinst.account"
    value = local.account_id
  }

  set {
    name  = "spotinst.clusterIdentifier"
    value = local.eks_cluster_name
  }

  set {
    name  = "metrics-server.deployChart"
    value = "false"
  }
}
