variable "project_id" {
  type    = string
  default = "6f2600e2-7b1a-468d-a7f4-f36569eb8f19"
}

variable "region" {
  type    = string
  default = "fr-par"
}

variable "namespaces" {
  type = list(string)
}

variable "flux_target_path" {
  type    = string
  default = "configs/flux2"
}

variable "flux_components" {
  type = list(string)
}

variable "github_owner" {
  type    = string
  default = "vmarlier"
}

variable "repository_name" {
  type    = string
  default = "miniature-fiesta-flux-config"
}

variable "flux_token" {
  type    = string
  description = "Github token that will be used by Fluxv2, populated via environment variable."
}
