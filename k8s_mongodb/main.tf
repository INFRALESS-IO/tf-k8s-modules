# ----
# MAIN
# ----

resource "helm_release" "mongodb" {
  name       = "mongodb"
  repository = "${path.module}/charts"
  chart      = "mongodb"
  # version          = "7"
  namespace        = "${local.namespace}"
  create_namespace = true
  wait             = true
  values = [
    templatefile("${path.module}/files/teleport-agent/custom-values.yaml", { MONGODB_KEY= "${try(local.mongodb_key, "")}", BACKUP_IMAGE = "${try(local.backup_image, "")}", BACKUP_IMAGE_TAG = "${try(local.backup_image_tag, "")}", BACKUP_DB_NAME = "${try(local.backup_db_name, "")}", BACKUP_ENV = "${try(local.backup_env, "")}", BACKUP_S3_DESTINATION = "${try(local.backup_s3_destination, "")}", BACKUP_AWS_ACCESS_KEY = "${try(local.backup_aws_access_key, "")}", BACKUP_AWS_SECRET_KEY = "${try(local.backup_aws_secret_key, "")}", BACKUP_DB_PASSWORD = "${try(local.backup_db_password, "")}", BACKUP_DB_USERNAME = "${try(local.backup_db_username, "")}", NAMESPACE = "${try(local.namespace, "")}", AVAILABILITY_ZONE_1 = "${try(local.availability_zone_1, "")}", AVAILABILITY_ZONE_2 = "${try(local.local.availability_zone_2, "")}", AVAILABILITY_ZONE_3 = "${try(local.local.availability_zone_3, "")}" })
  ]
}
