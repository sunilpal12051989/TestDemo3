#vnet
resource "azurerm_virtual_network" "vnet" {
  name                = "${var.environment}-${var.project}-vnet"
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = var.address_space
  tags = {
    environment = var.environment
    module      = "network"
  }
}

#subnet
resource "azurerm_subnet" "subnet" {
  name                 = "${var.environment}-${var.project}-subnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.address_prefix
}