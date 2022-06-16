variable "crds" {
  description = "Custom Resource Definitions to create on the cluster"
  default     = {}
  type        = map(object({}))
}
