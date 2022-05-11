provider "helm" {
  kubernetes {
    host                   = data.terraform_remote_state.kubernetes.outputs.kubeconfig_host
    token                  = data.terraform_remote_state.kubernetes.outputs.kubeconfig_token
    cluster_ca_certificate = base64decode(data.terraform_remote_state.kubernetes.outputs.kubeconfig_ca_certificate)
  }
}

resource "kubectl_manifest" "sealed_secret_certificates" {
  yaml_body = templatefile(
    "${path.module}/configs/sealedsecret/certificates-secret.yaml",
    {
      name      = "sealed-secret-certificates"
      namespace = "kube-system"
      crt       = var.sealedsecret_tls-crt
      key       = file(var.sealedsecret_tls-key)
    }
  )
}

resource "helm_release" "sealed_secret" {
  name       = "sealed-secrets"
  namespace  = "kube-system"
  repository = "https://bitnami-labs.github.io/sealed-secrets"
  chart      = "sealed-secrets"

  set {
    name  = "secretName"
    value = "sealed-secret-certificates"
    type  = "string"
  }
}


