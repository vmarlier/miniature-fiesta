terraform {
  required_version = ">= 1.5"

  backend "s3" {
    bucket                      = "terraform-tfstate"
    key                         = "miniature-fiesta/cluster-kubernetes.tfstate"
    region                      = "fr-par"
    endpoint                    = "https://s3.fr-par.scw.cloud"
    skip_credentials_validation = true
    skip_region_validation      = true
  }

  required_providers {
    scaleway = {
      source  = "scaleway/scaleway"
      version = "~> 2.41.2"
    }
  }
}
