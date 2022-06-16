data "kubectl_path_documents" "crd" {
  for_each = var.crds
  pattern  = "${path.module}/manifests/${each.key}/*.yml"
}

locals {
  crds = merge([for c, crd in var.crds : { for id, manifest in data.kubectl_path_documents.crd[c].manifests : "${c}-${id}" => manifest }]...)
}

resource "kubectl_manifest" "crd" {
  for_each  = local.crds
  yaml_body = each.value

  # Avoid the creation of the `last-applied-configuration` annotation that is causing error on Kubernetes
  server_side_apply = true

  # When changing API versions, we need to make sure the new version is created before the old one is destroyed
  lifecycle {
    create_before_destroy = true
  }
}
