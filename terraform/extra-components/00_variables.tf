variable "flux_target_path" {
  type    = string
  default = "scaleway/miniature-fiesta"
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
  type        = string
  description = "Github token that will be used by Fluxv2, populated via environment variable."
}
