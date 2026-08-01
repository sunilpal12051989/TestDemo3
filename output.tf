output "vnet_name" {
  value = module.network.vnet_name
}

output "subnet_id" {
  value = module.network.subnet_id
}

output "vm_names" {
  value = module.compute.vm_name
}

output "private_ips" {
  value = module.compute.private_ip
}

output "lb_name" {
  value = module.lb.lb_name
}

output "public_ip" {
  value = module.lb.public_ip
}