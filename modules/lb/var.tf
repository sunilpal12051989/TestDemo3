variable "environment" {
  type = string
}

variable "project" {
  type = string
}

variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "nic_ids" {
  type = list(string)
}

variable "vm_count" {
  type = number
}