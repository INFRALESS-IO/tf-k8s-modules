# --------
# VERSIONS
# --------

terraform {
  required_providers {
    rancher2 = {
      source  = "rancher/rancher2"
      version = "~> 1.23.0"
    }
    time = {
      source  = "hashicorp/time"
      version = "~> 0.6.0"
    }
  }
}
