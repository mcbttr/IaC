# APPLICATION INSIGHTS
resource "azurerm_container_registry" "acr" {
  name                = "acr${var.workload}${var.region}${var.env}001"
  location            = var.location
  resource_group_name = var.rgname
  sku                 = var.acr_sku

  retention_policy {
    days    = var.acr_retention_policy_days
    enabled = var.acr_retention_policy_enabled
  }

  network_rule_set {
    default_action = var.acr_nw_ruleset_enabled
    ip_rule {
      action   = var.acr_nw_rule_set_ip_enabled
      ip_range = var.acr_nw_rule_set_ip_range1
    }
    ip_rule {
      action   = var.acr_nw_rule_set_ip_enabled
      ip_range = var.acr_nw_rule_set_ip_range2
    }
    virtual_network {
      action    = var.acr_vnet_rule_set_enabled
      subnet_id = var.acr_vnet_rule_set_subnet_id
    }
  }

  tags = {
    project = var.tag
    env     = var.env
  }
  depends_on = [var.app_depends_on]
}