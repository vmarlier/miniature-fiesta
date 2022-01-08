provider "kubernetes" {
    load_config_file = "false"

    host  = null_resource.kubeconfig.triggers.host
    token = null_resource.kubeconfig.triggers.token
    cluster_ca_certificate = base64decode(null_resource.kubeconfig.triggers.cluster_ca_certificate) 
}
