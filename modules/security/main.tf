resource "azurerm_network_security_group" "nsg" {
  name                = "${var.environment}-${var.project}-nsg"
  location            = var.location
  resource_group_name = var.resource_group_name
}

#nsg-rule
resource "azurerm_network_security_rule" "http" {
  name                        = "test123"
  priority                    = 300
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "80"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.nsg.name
}

#nsg-subnet-asso
resource "azurerm_subnet_network_security_group_association" "nsg-sub" {
  subnet_id                 = var.subnet_id
  network_security_group_id = azurerm_network_security_group.nsg.id
}