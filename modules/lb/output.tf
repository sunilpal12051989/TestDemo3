output "lb_id" {
  value = azurerm_lb.lb.id
}

output "lb_name" {
  value = azurerm_lb.lb.name
}

output "backend_pool_id" {
  value = azurerm_lb_backend_address_pool.bp.id
}

output "public_ip" {
  value = azurerm_public_ip.pip.ip_address
}