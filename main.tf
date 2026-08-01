resource "azurerm_resource_group" "rg" {
  name     = "${var.environment}-${var.project}-rg"
  location = var.location
}

data "azurerm_key_vault" "kv" {
  name                = "kv-ntms-workshop"
  resource_group_name = "kv-ntms-workshop"
}

data "azurerm_key_vault_secret" "kv" {
  name         = "vm-admin-password"
  key_vault_id = data.azurerm_key_vault.kv.id
}

#module-nw-1
module "network" {
  source              = "./modules/network"
  environment         = var.environment
  project             = var.project
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  address_prefix      = ["10.0.0.0/24"]
  address_space       = ["10.0.0.0/16"]
}

#module-security-1
module "security" {
  source              = "./modules/security"
  environment         = var.environment
  project             = var.project
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  subnet_id           = module.network.subnet_id
}

#module-vm-1
module "compute" {
  source              = "./modules/compute"
  environment         = var.environment
  project             = var.project
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  admin_password      = data.azurerm_key_vault_secret.kv.value
  admin_username      = var.admin_username
  subnet_id           = module.network.subnet_id
  vm_count            = var.vm_count
}

# MODULE 4: LOAD BALANCER
module "lb" {
  source = "./modules/lb"

  environment         = var.environment
  project             = var.project
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  nic_ids             = module.compute.nic_ids
  vm_count            = var.vm_count
}


