# ------
# LOCALS
# ------

locals {
  namespace = var.namespace
  mongodb_key = var.mongodb_key
  backup_image = var.backup_image
  backup_image_tag = var.backup_image_tag
  backup_db_name = var.backup_db_name
  backup_env = var.backup_env
  backup_db_username = var.backup_db_username
  backup_db_password = var.backup_db_password
  backup_s3_destination = var.backup_s3_destination
  backup_aws_access_key = var.backup_aws_access_key
  backup_aws_secret_key = var.backup_aws_secret_key
  availability_zone_1 = var.availability_zone_1
  availability_zone_2 = var.availability_zone_2
  availability_zone_3 = var.availability_zone_3
}
