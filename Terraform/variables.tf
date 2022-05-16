############## GLOBALS

variable "boolean_true" {
  default = ""
}

variable "boolean_false" {
  default = ""
}

variable "allow" {
  default = ""
}

variable "deny" {
  default = ""
}

############## CREDENTIALS

variable "env" {
  default = ""
}

variable "workload" {
  default = ""
}

variable "region" {
  default = ""
}

variable "location" {
  default = ""
}

variable "subscriptionid" {
  default = ""
}

variable "tenantid" {
  default = ""
}

variable "rg_enabled" {
  default = 0
}

############### NETWORK
variable "nw_enabled" {
  default = 0
}

variable "networkcidr" {
  default = ""
}

variable "subnet1" {
  default = ""
}

variable "subnet2" {
  default = ""
}

variable "subnet3" {
  default = ""
}

############## AKS
variable "aks_enabled" {
  default = 0
}

variable "aksinstancesize" {
  default = ""
}

variable "networkaks" {
  default = ""
}

variable "skulbaks" {
  default = ""
}

variable "default_node_pool_name" {
  default = ""
}

variable "registry-enabled" {
  default = 0
}

variable "aks_network_policy" {
  default = ""
}

variable "max_pods" {
  default = ""
}

variable "node_count" {
  default = ""
}

variable "id_type" {
  default = ""
}

variable "aks_availability_zones" {
  default = ""
}

variable "aks_os_disk_size_gb" {
  default = ""
}

############## CONTAINER REGISTRY

variable "acr_enabled" {
  default = 0
}

variable "acr_sku" {
  default = ""
}

variable "acr_retention_policy_days" {
  default = ""
}

variable "acr_nw_rule_set_ip_range1" {
  default = ""
}

variable "acr_nw_rule_set_ip_range2" {
  default = ""
}

############## VIRTUAL MACHINE
variable "vm_enabled" {
  default = 0

}

variable "vm_size" {
  default = ""
}

variable "vm_publisher" {
  default = ""
}

variable "vm_offer" {
  default = ""
}

variable "vm_sku" {
  default = ""

}

variable "vm_osversion" {
  default = ""

}

variable "vm_diskcache" {
  default = ""

}

variable "vm_hostname" {
  default = ""

}

variable "vm_disk_type" {
  default = ""

}

variable "vm_priv_ip_address" {
  default = ""

}

variable "vm_disk_size_gb" {
  default = ""

}

############### KEY VAULT
variable "kv_enabled" {
  default = 0
}

variable "kv_sku_name" {
  default = ""
}


############### DATA LAKE
variable "dl_enabled" {
  default = 0
}

variable "sa_dl_account_tier" {
  default = ""
}

variable "sa_dl_account_replication_type" {
  default = ""
}

variable "sa_dl_account_kind" {
  default = ""
}

variable "dl_ip_rules" {
  default = ""
}

variable "dl_network_rules" {
  default = ""
}


############### COGNITIVE SERVICES
variable "cs_enabled" {
  default = 0
}

variable "cog_serv_kind" {
  default = ""

}

variable "cs_sku" {
  default = ""

}

variable "cog_ip_rules" {
  default = ""

}


############### LOGANALYTICS
variable "loganalytics_enabled" {
  default = 0

}

variable "log_sku" {
  default = ""

}

variable "log_retention_in_days" {
  default = ""
}

############### APP INSIGHTS
variable "appinsigths_enabled" {
  default = 0
}

variable "app_type" {
  default = ""
}

############### COSMOS DB
variable "cosmosdb_enabled" {
  default = 0
}

variable "cosmos_offer_type" {
  default = ""
}

variable "cosmos_kind" {
  default = ""
}

variable "cosmos_consistency_level" {
  default = ""
}

variable "cosmos_consistency_max_interval" {
  default = ""
}

variable "cosmos_consistency_max_staleness" {
  default = ""
}

variable "cosmos_ip_filter" {
  default = ""
}

variable "cosmos_backup_type" {
  default = ""
}

variable "cosmos_backup_interval" {
  default = ""
}

variable "cosmos_backup_retention" {
  default = ""
}

variable "cosmos_failover_prio" {
  default = ""
}

variable "cosmosdb_throughput" {
  default = ""
}

variable "prd_cosmos_db_enabled" {
  default = ""
}

variable "dev_cosmos_db_enabled" {
  default = ""
}

############### TAGS
variable "ocr_tag" {
  default = ""
}