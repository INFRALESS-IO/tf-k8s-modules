# ---------
# VARIABLES
# ---------

variable "prefix" {
  default     = null
  description = "Global Prefix"
}

variable "rancher_hostname" {
  default     = null
  description = "Rancher Domain"
}

variable "rancher_version" {
  default     = null
  description = "Rancher Domain"
}

variable "rancher_certificate_arn" {
  default     = null
  description = "Rancher Certificate ARN to be used on Network Load Balance"
}

variable "acm_domain_name" {
  default     = null
  description = "ACM Domain Name"
}

variable "eks_cluster_name" {
  default     = null
  description = "EKS Cluster Name"
}

variable "eks_cluster_oidc_provider_url" {
  default = null
}

variable "eks_cluster_endpoint" {
  default = null
}

variable "eks_cluter_auth_token" {
  default = null
}

variable "eks_cluster_certificate_authority_data" {
  default = null
}

variable "vpc_id" {
  default     = null
  description = "AWS VPC ID"
}

variable "aws_region" {
  default     = null
  description = "AWS Account Region"
}

variable "aws_profile" {
  default     = null
  description = "AWS Account Region"
}

variable "aws_role_arn" {
  default     = null
  description = "AWS Role ARN"
}


variable "letsencrypt_email" {
  default     = "email@domain.com"
  description = "Rancher Domain"
}

variable "rancher_private_tls_cert" {}
variable "rancher_private_tls_key" {}
variable "rancher_private_tls_ca_cert" {}

variable "public_access" {
  description = "Whether to create public LB"
  type        = bool
  default     = false
}
