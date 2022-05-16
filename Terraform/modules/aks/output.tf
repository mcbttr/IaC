output "aks_name" {
  value = azurerm_kubernetes_cluster.clusterkubernetes.name
}

output "client_certificate" {
  value = azurerm_kubernetes_cluster.clusterkubernetes.kube_config.0.client_certificate
}

output "kube_config" {
  value = azurerm_kubernetes_cluster.clusterkubernetes.kube_config_raw
}
