resource "azurerm_cosmosdb_account" "cosmosacc" {
  name                          = "cosmos-${var.workload}-${var.region}-${var.env}-001"
  location                      = var.location
  resource_group_name           = var.rgname
  offer_type                    = var.cosmos_offer_type
  kind                          = var.cosmos_kind
  enable_free_tier              = var.cosmos_free_tier
  ip_range_filter               = var.cosmos_ip_filter
  public_network_access_enabled = var.cosmos_pub_nw_access

  consistency_policy {
    consistency_level       = var.cosmos_consistency_level
    max_interval_in_seconds = var.cosmos_consistency_max_interval
    max_staleness_prefix    = var.cosmos_consistency_max_staleness
  }

  enable_automatic_failover = var.cosmos_automatic_failover

  geo_location {
    location          = var.location
    failover_priority = var.cosmos_failover_prio
  }

  is_virtual_network_filter_enabled = true

  virtual_network_rule {
    id = var.subnet_ids
  }

  backup {
    type                = var.cosmos_backup_type
    interval_in_minutes = var.cosmos_backup_interval
    retention_in_hours  = var.cosmos_backup_retention
  }

  tags = {
    project = var.tag
    env     = var.env
  }
  depends_on = [var.app_depends_on]
}

# DEV DB
resource "azurerm_cosmosdb_sql_database" "cdbdev" {
  count               = var.dev_cosmos_db_enabled-count
  name                = "cdb-${var.workload}-${var.region}-${var.env}-001"
  resource_group_name = var.rgname
  account_name        = azurerm_cosmosdb_account.cosmosacc.name
  throughput          = var.cosmosdb_throughput
}

# PRD DB
resource "azurerm_cosmosdb_sql_database" "cdbprod" {
  count               = var.prd_cosmos_db_enabled-count
  name                = "cdb-${var.workload}-${var.region}-${var.env}-001"
  resource_group_name = var.rgname
  account_name        = azurerm_cosmosdb_account.cosmosacc.name

  autoscale_settings {
    max_throughput = var.cosmosdb_throughput
  }
}