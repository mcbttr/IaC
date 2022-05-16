resource "azurerm_application_insights" "appsinsights" {
  name                = "appi-${var.workload}-${var.region}-${var.env}-001"
  location            = var.location
  resource_group_name = var.rgname
  application_type    = var.application_type

  tags = {
    project = var.tag
    env     = var.env
  }
}

