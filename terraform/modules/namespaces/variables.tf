variable "namespaces" {
  description = "Namespaces to manage on a Kubernetes cluster"
  default     = {}
  type = map(object({
    labels : optional(map(string)),
    annotations : optional(map(string))
  }))
}
