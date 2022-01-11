data "terraform_remote_state" "kubernetes" {
  backend = "s3"
  config = {
    bucket                      = "terraform-tfstate"
    key                         = "miniature-fiesta/kubernetes-terraform.tfstate"
    region                      = "fr-par"
    endpoint                    = "https://s3.fr-par.scw.cloud"
    skip_credentials_validation = true
    skip_region_validation      = true
  }
}

provider "kubernetes" {
  host                   = data.terraform_remote_state.kubernetes.outputs.kubeconfig_host
  token                  = data.terraform_remote_state.kubernetes.outputs.kubeconfig_token
  cluster_ca_certificate = base64decode(data.terraform_remote_state.kubernetes.outputs.kubeconfig_ca_certificate)
}

provider "kubectl" {
  host                   = data.terraform_remote_state.kubernetes.outputs.kubeconfig_host
  token                  = data.terraform_remote_state.kubernetes.outputs.kubeconfig_token
  cluster_ca_certificate = base64decode(data.terraform_remote_state.kubernetes.outputs.kubeconfig_ca_certificate)
}

# Generate manifests for setting up Fluxv2
data "flux_install" "main" {
  target_path = var.flux_target_path

  components           = toset(var.flux_components)
  namespace            = "flux-system"
  network_policy       = true
  registry             = "ghcr.io/fluxcd"
  version              = "v0.24.1"
  watch_all_namespaces = true
}

# Generate GitRepository and Kustomize resources
data "flux_sync" "main" {
  target_path = "clusters/my-cluster"
  url         = "https://github.com/${var.github_owner}/${var.repository_name}"
  branch      = "master"
}

# Split multi-doc YAML with
# https://registry.terraform.io/providers/gavinbunney/kubectl/latest
data "kubectl_file_documents" "apply" {
  content = data.flux_install.main.content
}

# Split multi-doc YAML with
# https://registry.terraform.io/providers/gavinbunney/kubectl/latest
data "kubectl_file_documents" "sync" {
  content = data.flux_sync.main.content
}

# Convert documents list to include parsed yaml data
locals {
  apply = [for v in data.kubectl_file_documents.apply.documents : {
    data : yamldecode(v)
    content : v
    }
  ]

  sync = [for v in data.kubectl_file_documents.sync.documents : {
    data : yamldecode(v)
    content : v
    }
  ]
}

# Apply manifests on the cluster
resource "kubectl_manifest" "apply" {
  for_each  = { for v in local.apply : lower(join("/", compact([v.data.apiVersion, v.data.kind, lookup(v.data.metadata, "namespace", ""), v.data.metadata.name]))) => v.content }
  yaml_body = each.value
}

# Generate a Kubernetes secret with the Git credentials
resource "kubernetes_secret" "main" {
  depends_on = [kubectl_manifest.apply]

  metadata {
    name      = data.flux_sync.main.secret
    namespace = data.flux_sync.main.namespace
  }

  data = {
    username = "git"
    password = var.flux_token
  }
}

# Apply manifests on the cluster
resource "kubectl_manifest" "sync" {
  for_each   = { for v in local.sync : lower(join("/", compact([v.data.apiVersion, v.data.kind, lookup(v.data.metadata, "namespace", ""), v.data.metadata.name]))) => v.content }
  depends_on = [kubernetes_secret.main]
  yaml_body  = each.value
}


