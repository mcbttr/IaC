resource "azurerm_cognitive_account" "cogacc" {
  name                  = "cogs-${var.workload}-${var.region}-${var.env}-001"
  location              = var.location
  resource_group_name   = var.rgname
  kind                  = var.kind
  sku_name              = var.sku_name
  custom_subdomain_name = "cogs${var.env}${var.workload}${var.env}001"
  local_auth_enabled    = true

  network_acls {
    default_action = var.cog_nw_defaultaction
    ip_rules       = var.cog_ip_rules
    virtual_network_rules {
      subnet_id = var.cog_subnet_id
    }
  }

  tags = {
    project = var.tag
    env     = var.env
  }
  depends_on = [var.app_depends_on]
}