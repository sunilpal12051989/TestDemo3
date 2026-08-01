# Public IP — Standard SKU required for Standard LB
resource "azurerm_public_ip" "pip" {
  name                = "${var.environment}-ntms-${var.project}-pip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"

  tags = {
    environment = var.environment
    module      = "lb"
  }
}

# External Load Balancer
# Frontend IP references Public IP — not subnet
resource "azurerm_lb" "lb" {
  name                = "${var.environment}-ntms-${var.project}-lb"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "Standard"

  frontend_ip_configuration {
    name                 = "${var.environment}-ntms-${var.project}-frontend"
    public_ip_address_id = azurerm_public_ip.pip.id
  }

  tags = {
    environment = var.environment
    module      = "lb"
  }
}

# Backend Address Pool — VMs registered here
resource "azurerm_lb_backend_address_pool" "bp" {
  name            = "${var.environment}-ntms-${var.project}-bp"
  loadbalancer_id = azurerm_lb.lb.id
}

# Health Probe — checks VM on port 80
resource "azurerm_lb_probe" "hp" {
  name            = "${var.environment}-ntms-${var.project}-hp"
  loadbalancer_id = azurerm_lb.lb.id
  protocol        = "Http"
  port            = 80
  request_path    = "/"
}

# LB Rule — distributes HTTP traffic to backend pool
resource "azurerm_lb_rule" "lb_rule" {
  name                           = "${var.environment}-ntms-${var.project}-lbrule"
  loadbalancer_id                = azurerm_lb.lb.id
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = "${var.environment}-ntms-${var.project}-frontend"
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.bp.id]
  probe_id                       = azurerm_lb_probe.hp.id
}

# NIC Backend Pool Association
# count = vm_count — same number as VMs created in compute module
resource "azurerm_network_interface_backend_address_pool_association" "nic_bp_assoc" {
  count                   = var.vm_count
  network_interface_id    = var.nic_ids[count.index]
  ip_configuration_name   = "internal"
  backend_address_pool_id = azurerm_lb_backend_address_pool.bp.id
}