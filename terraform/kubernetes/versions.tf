terraform {
  required_providers {
    scaleway = {
      source  = "scaleway/scaleway"
      version = "2.2.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.7.1"
    }
    time = {
      source  = "hashicorp/time"
      version = "0.7.2"
    }
  }
  required_version = "~> 1.0.4"
}

