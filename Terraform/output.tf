output "setup_kubectl" {
  value = "az aks get-credentials --resource-group ${module.resourcegroup[0].rg_name} --name ${module.aks[0].aks_name} --overwrite-existing --subscription ${var.subscriptionid}"
}