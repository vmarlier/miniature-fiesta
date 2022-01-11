output "k8s_cluster_id" {
  value = scaleway_k8s_cluster.fiesta_cluster.id
}

output "ip_lb_kapsule" {
  value = scaleway_lb_ip.fiesta_public_ip.ip_address
}

output "k8s_kubeconfig" {
  value     = scaleway_k8s_cluster.fiesta_cluster.kubeconfig[0].config_file
  sensitive = true
}

output "kubeconfig_host" {
  value     = scaleway_k8s_cluster.fiesta_cluster.kubeconfig[0].host
  sensitive = true
}

output "kubeconfig_token" {
  value     = scaleway_k8s_cluster.fiesta_cluster.kubeconfig[0].token
  sensitive = true
}

output "kubeconfig_ca_certificate" {
  value     = scaleway_k8s_cluster.fiesta_cluster.kubeconfig[0].cluster_ca_certificate
  sensitive = true
}
