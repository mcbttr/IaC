#Provider azure
provider "azurerm" {
  tenant_id       = var.tenantid
  subscription_id = var.subscriptionid
  features {}
}

#Provide kubernetes
provider "kubernetes" {
  config_path = "~/.kube/config"
}

#Terraform version and workspaces
terraform {
  required_version = "~> 1.0.7"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.78.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "= 2.7.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "= 2.6.1"
    }
  }
  backend "azurerm" {
    storage_account_name = "terraform-state"
    container_name       = "terraform"
    key                  = "terraform.tfstate"
    resource_group_name  = "rg-state-terraform"
  }
}

#Not allowed using default workspace
# locals {
#   assert_not_default_workspace = terraform.workspace == "default" ? file("ERROR: default workspace not allowed") : null
# }

module "resourcegroup" {
  count    = var.rg_enabled
  source   = "./modules/resourcegroup"
  env      = var.env
  workload = var.workload
  region   = var.region
  location = var.location
}

module "aks" {
  count                  = var.aks_enabled
  source                 = "./modules/aks"
  env                    = var.env
  workload               = var.workload
  region                 = var.region
  location               = module.resourcegroup[0].rg_location
  rgname                 = module.resourcegroup[0].rg_name
  aksinstancesize        = var.aksinstancesize
  max_pods               = var.max_pods
  node_count             = var.node_count
  id_type                = var.id_type
  networkaks             = var.networkaks
  skulbaks               = var.skulbaks
  subnet_id              = module.network[0].subnet1_id
  default_node_pool_name = var.default_node_pool_name
  aks_network_policy     = var.aks_network_policy
  aks_availability_zones = var.aks_availability_zones
  aks_os_disk_size_gb    = var.aks_os_disk_size_gb
  aks_rg_id              = module.resourcegroup[0].rg_id
  tag                    = var.ocr_tag
  app_depends_on         = [module.network]
}

module "acr" {
  count                        = var.acr_enabled
  source                       = "./modules/acr"
  env                          = var.env
  workload                     = var.workload
  region                       = var.region
  location                     = module.resourcegroup[0].rg_location
  rgname                       = module.resourcegroup[0].rg_name
  acr_sku                      = var.acr_sku
  acr_retention_policy_days    = var.acr_retention_policy_days
  acr_retention_policy_enabled = var.boolean_true
  acr_nw_ruleset_enabled       = var.deny
  acr_nw_rule_set_ip_enabled   = var.allow
  acr_nw_rule_set_ip_range1    = var.acr_nw_rule_set_ip_range1
  acr_nw_rule_set_ip_range2    = var.acr_nw_rule_set_ip_range2
  acr_vnet_rule_set_enabled    = var.allow
  acr_vnet_rule_set_subnet_id  = module.network[0].subnet2_id
  tag                          = var.ocr_tag
  app_depends_on               = [module.network]
}

module "network" {
  count       = var.nw_enabled
  source      = "./modules/network"
  env         = var.env
  workload    = var.workload
  region      = var.region
  location    = module.resourcegroup[0].rg_location
  rgname      = module.resourcegroup[0].rg_name
  networkcidr = var.networkcidr
  subnet1     = var.subnet1
  subnet2     = var.subnet2
  subnet3     = var.subnet3
  tag         = var.ocr_tag
}

module "keyvault" {
  count       = var.kv_enabled
  source      = "./modules/keyvault"
  env         = var.env
  workload    = var.workload
  region      = var.region
  location    = module.resourcegroup[0].rg_location
  rgname      = module.resourcegroup[0].rg_name
  kv_sku_name = var.kv_sku_name
  tag         = var.ocr_tag
}

module "datalake" {
  count                          = var.dl_enabled
  source                         = "./modules/datalake"
  env                            = var.env
  workload                       = var.workload
  region                         = var.region
  location                       = module.resourcegroup[0].rg_location
  rgname                         = module.resourcegroup[0].rg_name
  sa_dl_account_tier             = var.sa_dl_account_tier
  sa_dl_account_replication_type = var.sa_dl_account_replication_type
  sa_dl_account_kind             = var.sa_dl_account_kind
  subnet_ids                     = module.network[0].subnet2_id
  dl_ip_rules                    = var.dl_ip_rules
  dl_network_rules               = var.dl_network_rules
  is_hns_enabled                 = var.boolean_true
  tag                            = var.ocr_tag
  app_depends_on                 = [module.network]
}

module "vm" {
  count              = var.vm_enabled
  source             = "./modules/vm"
  env                = var.env
  workload           = var.workload
  region             = var.region
  location           = module.resourcegroup[0].rg_location
  rgname             = module.resourcegroup[0].rg_name
  vm_size            = var.vm_size
  vm_publisher       = var.vm_publisher
  vm_offer           = var.vm_offer
  vm_sku             = var.vm_sku
  vm_osversion       = var.vm_osversion
  vm_diskcache       = var.vm_diskcache
  vm_hostname        = var.vm_hostname
  vm_nic_subnet_ids  = module.network[0].subnet2_id
  vm_priv_ip_address = var.vm_priv_ip_address
  vm_disk_type       = var.vm_disk_type
  vm_disk_size_gb    = var.vm_disk_size_gb
  tag                = var.ocr_tag
  app_depends_on     = [module.network]
}

module "cognitiveservices" {
  count                = var.cs_enabled
  source               = "./modules/cognitiveservices"
  env                  = var.env
  workload             = var.workload
  region               = var.region
  location             = module.resourcegroup[0].rg_location
  rgname               = module.resourcegroup[0].rg_name
  kind                 = var.cog_serv_kind
  sku_name             = var.cs_sku
  cog_nw_defaultaction = var.deny
  cog_ip_rules         = var.cog_ip_rules
  cog_subnet_id        = module.network[0].subnet2_id
  tag                  = var.ocr_tag
  app_depends_on       = [module.network]
}

module "cosmosdb" {
  count                            = var.cosmosdb_enabled
  source                           = "./modules/cosmosdb"
  env                              = var.env
  workload                         = var.workload
  region                           = var.region
  location                         = module.resourcegroup[0].rg_location
  rgname                           = module.resourcegroup[0].rg_name
  cosmos_offer_type                = var.cosmos_offer_type
  cosmos_kind                      = var.cosmos_kind
  cosmos_consistency_level         = var.cosmos_consistency_level
  cosmos_consistency_max_interval  = var.cosmos_consistency_max_interval
  cosmos_consistency_max_staleness = var.cosmos_consistency_max_staleness
  cosmos_automatic_failover        = var.boolean_false
  cosmos_ip_filter                 = var.cosmos_ip_filter
  cosmos_pub_nw_access             = var.boolean_true
  cosmos_free_tier                 = var.boolean_true
  subnet_ids                       = module.network[0].subnet2_id
  cosmos_backup_type               = var.cosmos_backup_type
  cosmos_backup_interval           = var.cosmos_backup_interval
  cosmos_backup_retention          = var.cosmos_backup_retention
  cosmos_failover_prio             = var.cosmos_failover_prio
  cosmosdb_throughput              = var.cosmosdb_throughput
  prd_cosmos_db_enabled-count      = var.prd_cosmos_db_enabled
  dev_cosmos_db_enabled-count      = var.dev_cosmos_db_enabled
  app_depends_on                   = [module.network]
}



module "loganalytics" {
  count             = var.loganalytics_enabled
  source            = "./modules/loganalytics"
  env               = var.env
  workload          = var.workload
  region            = var.region
  location          = module.resourcegroup[0].rg_location
  rgname            = module.resourcegroup[0].rg_name
  log_sku           = var.log_sku
  retention_in_days = var.log_retention_in_days
  tag               = var.ocr_tag
}

module "appinsigths" {
  count            = var.appinsigths_enabled
  source           = "./modules/appinsigths"
  env              = var.env
  workload         = var.workload
  region           = var.region
  location         = module.resourcegroup[0].rg_location
  rgname           = module.resourcegroup[0].rg_name
  application_type = var.app_type
  tag              = var.ocr_tag
}

