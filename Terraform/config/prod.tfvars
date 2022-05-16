#GLOBAL VARIABLES
boolean_true  = "true"
boolean_false = "false"
allow         = "Allow"
deny          = "Deny"

#ACCOUNT/ENV
env            = "prd"
workload       = "###"
region         = "brs"
location       = "brazilsouth"
subscriptionid = "##############################" 
tenantid       = "##############################" 
rg_enabled     = 1

#TAGS
ocr_tag = "ocr"

#NETWORK
nw_enabled  = 1
networkcidr = "10.24.8.0/21"   
subnet1     = "10.24.8.0/22"   
subnet2     = "10.24.10.0/27"  
subnet3     = "10.24.10.32/27" 

#AKS
aks_enabled            = 1
aksinstancesize        = "Standard_F8s"
node_count             = 1 #prd setar para 3
max_pods               = 250
id_type                = "SystemAssigned"
networkaks             = "azure"
skulbaks               = "Standard"
default_node_pool_name = "default"
aks_network_policy     = "azure"
aks_availability_zones = [2]
aks_os_disk_size_gb    = 32

#ACR
acr_enabled               = 1
acr_sku                   = "Premium"
acr_retention_policy_days = 30
acr_nw_rule_set_ip_range1 = "###.###.###.###"
acr_nw_rule_set_ip_range2 = "###.###.###.###"

#STORAGE ACCOUNT
sa_dl_account_tier             = "Standard"
sa_dl_account_replication_type = "LRS"
sa_dl_account_kind             = "StorageV2"

#DATA LAKE
dl_enabled       = 1
dl_network_rules = "Deny"
dl_ip_rules      = ["###.###.###.###", "###.###.###.###"]

#KEYVAULT
kv_enabled  = 1
kv_sku_name = "standard"

#VM - 198h
vm_enabled         = 1
vm_size            = "Standard_F8"
vm_publisher       = "Canonical"
vm_offer           = "UbuntuServer"
vm_sku             = "16.04-LTS"
vm_osversion       = "latest"
vm_diskcache       = "ReadWrite"
vm_hostname        = "devmodeltraining"
vm_priv_ip_address = "Dynamic"
vm_disk_type       = "Standard_LRS"
vm_disk_size_gb    = 64

#COGNITIVE SERVICES
cs_enabled    = 1
cog_serv_kind = "ComputerVision"
cs_sku        = "S1"
cog_ip_rules  = ["###.###.###.###", "###.###.###.###"]

#COSMOSDB
cosmosdb_enabled                 = 1
cosmos_offer_type                = "Standard"
cosmos_kind                      = "GlobalDocumentDB"
cosmos_consistency_level         = "BoundedStaleness"
cosmos_consistency_max_interval  = 10
cosmos_consistency_max_staleness = 200
cosmos_ip_filter                 = "###.###.###.###, ###.###.###.###"
cosmos_backup_type               = "Periodic"
cosmos_backup_interval           = 60
cosmos_backup_retention          = 8
cosmos_failover_prio             = 0
cosmosdb_throughput              = 4000
dev_cosmos_db_enabled            = 0
prd_cosmos_db_enabled            = 1


#LOG ANALYTICS
loganalytics_enabled  = 1
log_sku               = "PerGB2018"
log_retention_in_days = 30

#APP INSIGHTS
appinsigths_enabled = 1
app_type            = "other"
