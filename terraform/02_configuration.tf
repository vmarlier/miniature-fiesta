provider "kubernetes" {
  host                   = scaleway_k8s_cluster.fiesta_cluster.kubeconfig[0].host
  token                  = scaleway_k8s_cluster.fiesta_cluster.kubeconfig[0].token
  cluster_ca_certificate = base64decode(scaleway_k8s_cluster.fiesta_cluster.kubeconfig[0].cluster_ca_certificate)
}

resource "kubernetes_namespace" "namespaces" {
  depends_on = [time_sleep.wait_60_seconds_after_pool_creation]
  for_each   = toset(var.namespaces)

  metadata {
    name = each.value

    labels = {
      managed-by = "terraform"
    }
  }
}

