#VNET
resource "azurerm_virtual_network" "vnet" {
  name                = "vnet-${var.workload}-${var.region}-${var.env}-001"
  resource_group_name = var.rgname
  location            = var.location
  address_space       = [var.networkcidr]

  tags = {
    project = var.tag
    env     = var.env
  }
}

#Subnet1
resource "azurerm_subnet" "subnet1" {
  name                                           = "snet-${var.workload}-${var.region}-${var.env}-001"
  resource_group_name                            = var.rgname
  virtual_network_name                           = azurerm_virtual_network.vnet.name
  address_prefixes                               = [var.subnet1]
  enforce_private_link_endpoint_network_policies = true
  service_endpoints                              = ["Microsoft.Storage"]
  depends_on                                     = [azurerm_virtual_network.vnet]
}

#Subnet2
resource "azurerm_subnet" "subnet2" {
  name                                           = "snet-${var.workload}-${var.region}-${var.env}-002"
  resource_group_name                            = var.rgname
  virtual_network_name                           = azurerm_virtual_network.vnet.name
  address_prefixes                               = [var.subnet2]
  enforce_private_link_endpoint_network_policies = true
  service_endpoints                              = ["Microsoft.Storage", "Microsoft.ContainerRegistry", "Microsoft.CognitiveServices", "Microsoft.AzureCosmosDB"]
  depends_on                                     = [azurerm_virtual_network.vnet]
}

#Subnet3
# resource "azurerm_subnet" "subnet3" {
#   name                                           = "snet-${var.workload}-${var.region}-${var.env}-003"
#   resource_group_name                            = var.rgname
#   virtual_network_name                           = azurerm_virtual_network.vnet.name
#   address_prefixes                               = [var.subnet3]
#   enforce_private_link_endpoint_network_policies = true
#   service_endpoints                              = ["Microsoft.Storage"]
#   depends_on                                     = [azurerm_virtual_network.vnet]
# }
