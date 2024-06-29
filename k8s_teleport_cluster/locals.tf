# ------
# LOCALS
# ------

locals {
  acme_email   = var.acme_email
  cluster_name = var.cluster_name
  prefix       = var.prefix
  root_domain  = var.root_domain
  image        = var.image
  image_tag    = var.image_tag
}
