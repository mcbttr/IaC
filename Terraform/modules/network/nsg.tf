#NSG subnet1
resource "azurerm_network_security_group" "subnet1" {
  name                = "nsg-${var.workload}-${var.region}-${var.env}-001"
  location            = var.location
  resource_group_name = var.rgname
  depends_on          = [var.app_depends_on]
}

# NSG ASSOCIATION 1
resource "azurerm_subnet_network_security_group_association" "subnet1" {
  subnet_id                 = azurerm_subnet.subnet1.id
  network_security_group_id = azurerm_network_security_group.subnet1.id
  depends_on                = [var.app_depends_on]
}

#NSG subnet2
resource "azurerm_network_security_group" "subnet2" {
  name                = "nsg-${var.workload}-${var.region}-${var.env}-002"
  location            = var.location
  resource_group_name = var.rgname

  security_rule {
    name                       = "vm-test"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefixes    = ["189.55.34.16", "200.236.236.76"]
    destination_address_prefix = "*"
  }
  depends_on = [var.app_depends_on]
}

# NSG ASSOCIATION 2
resource "azurerm_subnet_network_security_group_association" "subnet2" {
  subnet_id                 = azurerm_subnet.subnet2.id
  network_security_group_id = azurerm_network_security_group.subnet2.id
  depends_on                = [var.app_depends_on]
}

#NSG subnet3
resource "azurerm_network_security_group" "subnet3" {
  name                = "nsg-${var.workload}-${var.region}-${var.env}-003"
  location            = var.location
  resource_group_name = var.rgname

  # security_rule {
  #   name                       = "apim"
  #   priority                   = 100
  #   direction                  = "Inbound"
  #   access                     = "Allow"
  #   protocol                   = "Tcp"
  #   source_port_range          = "*"
  #   destination_port_range     = "3443"
  #   source_address_prefix      = "ApiManagement"
  #   destination_address_prefix = "VirtualNetwork"
  # }

  # security_rule {
  #   name                       = "api-test"
  #   priority                   = 200
  #   direction                  = "Inbound"
  #   access                     = "Allow"
  #   protocol                   = "Tcp"
  #   source_port_range          = "*"
  #   destination_port_range     = "*"
  #   source_address_prefixes    = ["189.55.34.16", "200.236.236.76"]
  #   destination_address_prefix = "*"
  # }
  depends_on = [var.app_depends_on]
}

# NSG ASSOCIATION 3
resource "azurerm_subnet_network_security_group_association" "subnet3" {
  subnet_id                 = azurerm_subnet.subnet3.id
  network_security_group_id = azurerm_network_security_group.subnet3.id
  depends_on                = [var.app_depends_on]
}