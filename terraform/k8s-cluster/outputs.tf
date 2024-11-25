output "cluster_id" {
  value = module.kapsule.cluster_id
}

output "cluster_kubeconfig" {
  value     = module.kapsule.cluster_kubeconfig
  sensitive = true
}

output "cluster_host" {
  value     = module.kapsule.cluster_host
  sensitive = true
}

output "cluster_token" {
  value     = module.kapsule.cluster_token
  sensitive = true
}

output "cluster_ca_certificate" {
  value     = module.kapsule.cluster_ca_certificate
  sensitive = true
}
