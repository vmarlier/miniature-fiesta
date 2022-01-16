provider "helm" {
  kubernetes {
    host                   = data.terraform_remote_state.kubernetes.outputs.kubeconfig_host
    token                  = data.terraform_remote_state.kubernetes.outputs.kubeconfig_token
    cluster_ca_certificate = base64decode(data.terraform_remote_state.kubernetes.outputs.kubeconfig_ca_certificate)
  }
}

resource "helm_release" "sealed_secret" {
  name       = "sealed-secrets"
  namespace  = "kube-system"
  repository = "https://bitnami-labs.github.io/sealed-secrets"
  chart      = "sealed-secrets"
}


