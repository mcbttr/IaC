#AKS cluster
resource "azurerm_kubernetes_cluster" "clusterkubernetes" {
  name                = "k8s-${var.workload}-${var.region}-${var.env}-001"
  location            = var.location
  resource_group_name = var.rgname
  dns_prefix          = "${var.env}-${var.workload}"

  default_node_pool {
    name               = var.default_node_pool_name
    vm_size            = var.aksinstancesize
    node_count         = var.node_count
    max_pods           = var.max_pods
    vnet_subnet_id     = var.subnet_id
    availability_zones = var.aks_availability_zones
    os_disk_size_gb    = var.aks_os_disk_size_gb
  }

  identity {
    type = var.id_type
  }

  network_profile {
    network_policy    = var.aks_network_policy
    network_plugin    = var.networkaks
    load_balancer_sku = var.skulbaks
  }

  
  tags = {
    project = var.tag
    env     = var.env
  }

  depends_on = [var.app_depends_on]
}

data "azurerm_kubernetes_cluster" "clusterkubernetes" {
name = "k8s-${var.workload}-${var.region}-${var.env}-001"
resource_group_name = var.rgname
depends_on = [azurerm_kubernetes_cluster.clusterkubernetes]

}

resource "azurerm_role_assignment" "ManagedId" {
  scope                = var.aks_rg_id
  role_definition_name = "Network Contributor"
  principal_id         = data.azurerm_kubernetes_cluster.clusterkubernetes.identity[0].principal_id
  depends_on = [azurerm_kubernetes_cluster.clusterkubernetes]
}