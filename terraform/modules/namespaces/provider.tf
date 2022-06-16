terraform {
  required_version = ">= 1.1"

  # Used for optional attributes
  experiments = [module_variable_optional_attrs]

  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.7.1"
    }
  }
}
