variable "location" {
  type    = string
  default = "eastus"
}

variable "environment" {
  type    = string
  default = "prod"
}

variable "project" {
  type    = string
  default = "tf"
}

variable "admin_username" {
  type    = string
  default = "vmadmin"
}

variable "vm_count" {
  type    = number
  default = 1
}