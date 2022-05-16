resource "azurerm_resource_group" "rg" {
  name     = "rg-${var.workload}-${var.region}-${var.env}-001"
  location = var.location

  tags = {
    project = var.tag
    env     = var.env
  }

}