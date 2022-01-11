locals {
  tags = [
    "project=miniature-fiesta"
  ]
}

resource "scaleway_k8s_cluster" "fiesta_cluster" {
  name       = "fiesta"
  version    = "1.21.7"
  cni        = "calico"
  project_id = var.project_id
  region     = var.region
  tags       = local.tags
}

resource "scaleway_k8s_pool" "fiesta_pool" {
  cluster_id        = scaleway_k8s_cluster.fiesta_cluster.id
  name              = "default"
  node_type         = "DEV1-M"
  size              = 1
  min_size          = 0
  max_size          = 1
  autohealing       = false
  autoscaling       = false
  container_runtime = "containerd"
  tags              = local.tags
}

resource "scaleway_lb_ip" "fiesta_public_ip" {}

resource "time_sleep" "wait_60_seconds_after_pool_creation" {
  depends_on      = [scaleway_k8s_pool.fiesta_pool]
  create_duration = "60s"
}
