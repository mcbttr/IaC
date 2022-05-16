#PIP FOR TESTING
# resource "azurerm_public_ip" "vmpubi" {
#   name                = "testing-pip"
#   resource_group_name = var.rgname
#   location            = var.location
#   allocation_method   = "Dynamic"
#  }

# VM NIC
resource "azurerm_network_interface" "vmnic" {
  name                = "nic-${var.workload}-${var.region}-${var.env}-001"
  location            = var.location
  resource_group_name = var.rgname

  ip_configuration {
    name                          = "priv-ip-${var.workload}-${var.region}-${var.env}-001"
    subnet_id                     = var.vm_nic_subnet_ids
    private_ip_address_allocation = var.vm_priv_ip_address
    # public_ip_address_id          = azurerm_public_ip.vmpubi.id # Tirar após fechar ambiente
  }
  depends_on = [var.app_depends_on]
}

# VIRTUAL MACHINE
resource "azurerm_linux_virtual_machine" "vm" {
  name                = "vm-${var.workload}-${var.region}-${var.env}-001"
  location            = var.location
  resource_group_name = var.rgname
  size                = var.vm_size
  admin_username      = var.vm_hostname
  network_interface_ids = [
    azurerm_network_interface.vmnic.id
  ]

  source_image_reference {
    publisher = var.vm_publisher
    offer     = var.vm_offer
    sku       = var.vm_sku
    version   = var.vm_osversion
  }

  os_disk {
    caching              = var.vm_diskcache
    storage_account_type = var.vm_disk_type
    disk_size_gb         = var.vm_disk_size_gb
  }

  admin_ssh_key {
    username   = var.vm_hostname
    public_key = local.ssh
  }

  tags = {
    project = var.tag
    env     = var.env
  }
}