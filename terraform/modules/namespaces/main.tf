resource "kubernetes_namespace" "namespace" {
  for_each = var.namespaces
  metadata {
    name = each.key
    labels = merge(each.value.labels, {}, {
      "networking/namespace" = each.key
      "vault-injection"      = "enabled"
    })
    annotations = each.value.annotations
  }

  lifecycle {
    prevent_destroy = true
    ignore_changes = [
      metadata[0].annotations,
      metadata[0].labels["field.cattle.io/projectId"],
      metadata[0].labels["fluxcd.io/sync-gc-mark"],
      metadata[0].labels["control-plane"]
    ]
  }
}
