# DATA LAKE
resource "azurerm_storage_account" "datalake" {
  name                     = "dl${var.workload}${var.region}${var.env}001"
  resource_group_name      = var.rgname
  location                 = var.location
  account_tier             = var.sa_dl_account_tier
  account_replication_type = var.sa_dl_account_replication_type
  account_kind             = var.sa_dl_account_kind
  is_hns_enabled           = var.is_hns_enabled

  network_rules {
    default_action             = var.dl_network_rules
    ip_rules                   = var.dl_ip_rules
    virtual_network_subnet_ids = [var.subnet_ids]
  }

  tags = {
    project = var.tag
    env     = var.env
  }
  depends_on = [var.app_depends_on]
}

