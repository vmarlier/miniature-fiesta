terraform {
  required_version = ">= 1.5"

  backend "s3" {
    bucket                      = "terraform-tfstate"
    key                         = "miniature-fiesta/kubernetes-terraform.tfstate"
    region                      = "fr-par"
    endpoint                    = "https://s3.fr-par.scw.cloud"
    skip_credentials_validation = true
    skip_region_validation      = true
  }

  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.7.1"
    }
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = "~> 1.13.1"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.4.1"
    }
    ansiblevault = {
      source  = "MeilleursAgents/ansiblevault"
      version = "~> 2.2.0"
    }
    scaleway = {
      source  = "scaleway/scaleway"
      version = "~> 2.41.2"
    }
  }
}

data "terraform_remote_state" "cluster" {
  backend = "s3"
  config = {
    bucket                      = "terraform-tfstate"
    key                         = "miniature-fiesta/cluster-kubernetes.tfstate"
    region                      = "fr-par"
    endpoint                    = "https://s3.fr-par.scw.cloud"
    skip_credentials_validation = true
    skip_region_validation      = true
  }
}

provider "kubernetes" {
  host                   = data.terraform_remote_state.cluster.outputs.cluster_host
  token                  = data.terraform_remote_state.cluster.outputs.cluster_token
  cluster_ca_certificate = base64decode(data.terraform_remote_state.cluster.outputs.cluster_ca_certificate)
}

provider "kubectl" {
  host                   = data.terraform_remote_state.cluster.outputs.cluster_host
  token                  = data.terraform_remote_state.cluster.outputs.cluster_token
  cluster_ca_certificate = base64decode(data.terraform_remote_state.cluster.outputs.cluster_ca_certificate)
}

provider "helm" {
  kubernetes {
    host                   = data.terraform_remote_state.cluster.outputs.cluster_host
    token                  = data.terraform_remote_state.cluster.outputs.cluster_token
    cluster_ca_certificate = base64decode(data.terraform_remote_state.cluster.outputs.cluster_ca_certificate)
  }
}

variable "vault_pass" {
  type = string
}

provider "ansiblevault" {
  vault_pass  = var.vault_pass
  root_folder = "./"
}
