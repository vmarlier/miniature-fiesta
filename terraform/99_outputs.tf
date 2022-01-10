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
