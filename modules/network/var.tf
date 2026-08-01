variable "location" {
  type = string

}

variable "environment" {
  type = string

}

variable "project" {
  type = string

}

variable "resource_group_name" {
  type = string
}

variable "address_space" {
  type = list(string)
}

variable "address_prefix" {
  type = list(string)
}