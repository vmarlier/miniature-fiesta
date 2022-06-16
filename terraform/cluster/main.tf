module "kapsule" {
  source   = "git@github.com:vmarlier/terraform-modules.git//kapsule?ref=main"

  cluster_name    = "fr-production"
  cluster_version = "1.22.9"
  cluster_cni     = "calico"

  cluster_project_id = "6f2600e2-7b1a-468d-a7f4-f36569eb8f19"
  cluster_region     = "fr-par"

  shared_tags = [
    "project=miniature-fiesta",
    "environment=production"
  ]

  node_pools = {
    default = {
      node_type = "DEV1-M"
      zone      = "fr-par-1"
      region    = "fr-par"

      scaling = {
        size     = 1
        min_size = 1
        max_size = 1
      }

      autoscaling         = false
      autohealing         = false
      container_runtime   = "containerd"
      placement_group_id  = ""
      wait_for_pool_ready = false

      upgrade_policy = {
        max_surge       = 0
        max_unavailable = 1
      }

      kubelet_args = {}

      tags = [
        "environment=production",
        "project=miniature-fiesta",
        "type=default"
      ]
    }
  }
}
