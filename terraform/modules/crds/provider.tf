terraform {
  required_version = ">= 1.1"

  required_providers {
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = "~> 1.13.1"
    }
  }
}
