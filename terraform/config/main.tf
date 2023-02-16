module "namespaces" {
  source = "../modules/namespaces/"

  namespaces = {
    "admin" : {}
    "monitoring" : {}
    "ingress" : {}
  }
}

module "crds" {
  source = "../modules/crds/"

  crds = {
    "flux" : {}
    "sealed-secrets" : {}
    "prometheus" : {}
    "traefik" : {}
    "externaldns" : {}
  }
}

module "fluxv2" {
  source = "git@github.com:vmarlier/terraform-modules.git//fluxv2?ref=main"

  release_name  = "fluxv2"
  chart_version = "0.20.0"
  namespace     = "admin" # Namespace should be created before

  # Requests/Limits Resources adjusments
  helm_controller_cpu_requests    = "100m"
  helm_controller_cpu_limits      = "100m"
  helm_controller_memory_requests = "256Mi"
  helm_controller_memory_limits   = "256Mi"

  source_controller_cpu_requests    = "100m"
  source_controller_cpu_limits      = "100m"
  source_controller_memory_requests = "512Mi"
  source_controller_memory_limits   = "512Mi"

  kustomize_controller_cpu_requests    = "100m"
  kustomize_controller_cpu_limits      = "100m"
  kustomize_controller_memory_requests = "64Mi"
  kustomize_controller_memory_limits   = "64Mi"

  notification_controller_cpu_requests    = "100m"
  notification_controller_cpu_limits      = "100m"
  notification_controller_memory_requests = "64Mi"
  notification_controller_memory_limits   = "64Mi"

  git_repositories = {
    miniature-fiesta = {
      git_url           = "ssh://git@github.com/vmarlier/miniature-fiesta"
      git_branch        = "master"
      git_poll_interval = "1m"
      git_timeout       = "120s"
      git_public_key    = data.ansiblevault_string.fluxv2_public_key.value
      git_private_key   = data.ansiblevault_string.fluxv2_private_key.value
      git_known_hosts   = data.ansiblevault_string.fluxv2_known_host.value
      kustomizations = {
        common = {
          path     = "./config/common"
          interval = "30m"
          prune    = true
          wait     = false
          timeout  = "60s"
        },
        fr-production = {
          path     = "./config/fr-production"
          interval = "30m"
          prune    = true
          wait     = false
          timeout  = "60s"
        },
      }
    }
  }

  buckets = {}

  labels = {
    "app.kubernetes.io/name"    = "fluxv2"
    "app.kubernetes.io/part-of" = "admin-tooling"
  }
}

module "sealed_secret" {
  source = "git@github.com:vmarlier/terraform-modules.git//sealed-secret?ref=main"

  release_name  = "sealed-secret"
  chart_version = "2.2.0"
  namespace     = "admin"

  tls_key = data.ansiblevault_string.sealedsecret_tls_key.value
  tls_crt = data.ansiblevault_string.sealedsecret_tls_crt.value

  #service_monitor_labels = "default"
  #grafana_dashboard      = true

  labels = {}
}

resource "scaleway_object_bucket" "thanos" {
  name   = "thanos-fr-production"
  region = "fr-par"
  acl    = "private"

  lifecycle_rule {
    id      = "id1"
    enabled = true

    expiration {
      days = 365
    }
  }
}
