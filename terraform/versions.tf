terraform {
  required_providers {
    scaleway = {
      source = "scaleway/scaleway"
      version = "2.2.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.7.1"
    }
    null = {
      source = "hashicorp/null"
      version = "3.1.0"
    }
  }
  required_version = "~> 1.0.4"
}
