#Azure config
data "azurerm_client_config" "current" {}

# KEYVAULT
resource "azurerm_key_vault" "keyvault" {
  name                = "kv-${var.workload}-${var.region}-${var.env}-001"
  location            = var.location
  resource_group_name = var.rgname
  tenant_id           = data.azurerm_client_config.current.tenant_id
  sku_name            = var.kv_sku_name

  tags = {
    project = var.tag
    env     = var.env
  }

}