resource "azurerm_log_analytics_workspace" "loganalytics" {
  name                = "log-${var.workload}-${var.region}-${var.env}-001"
  location            = var.location
  resource_group_name = var.rgname
  sku                 = var.log_sku
  retention_in_days   = var.retention_in_days

  tags = {
    project = var.tag
    env     = var.env
  }
}

