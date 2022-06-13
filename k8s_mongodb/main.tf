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
    templatefile("${path.module}/files/teleport-agent/custom-values.yaml", { MONGODB_KEY= "${try(local.mongodb_key, "")}", BACKUP_IMAGE = "${try(local.backup_image, "")}", BACKUP_IMAGE_TAG = "${local.backup_image_tag, ""}", BACKUP_DB_NAME = "${local.backup_db_name, ""}", BACKUP_ENV = "${local.backup_env, ""}", BACKUP_S3_DESTINATION = "${local.backup_s3_destination, ""}", BACKUP_AWS_ACCESS_KEY = "${local.backup_aws_access_key, ""}", BACKUP_AWS_SECRET_KEY = "${local.backup_aws_secret_key, ""}", BACKUP_DB_PASSWORD = "${local.backup_db_password, ""}", BACKUP_DB_USERNAME = "${local.backup_db_username, ""}", NAMESPACE = "${local.namespace, ""}", AVAILABILITY_ZONE_1 = "${local.availability_zone_1, ""}", AVAILABILITY_ZONE_2 = "${local.local.availability_zone_2, ""}", AVAILABILITY_ZONE_3 = "${local.local.availability_zone_3, ""}" })
  ]
}
