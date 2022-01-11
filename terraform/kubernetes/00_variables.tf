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
