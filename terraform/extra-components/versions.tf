terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.7.1"
    }
    flux = {
      source  = "fluxcd/flux"
      version = "0.8.1"
    }
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = "1.13.1"
    }
  }
  required_version = "~> 1.0.4"
}

