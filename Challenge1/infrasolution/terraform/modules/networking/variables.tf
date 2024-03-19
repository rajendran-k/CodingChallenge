variable "group_name" {
  
  type = string
}

variable "location" {
  
  type = string
}

variable "virtual_network_name" {
    type = string
    default = "virtualnetwork"
  
}
variable "public_subnet_name" {  
   type = string
    default = "publicsubnet"
}
variable "private_subnet_name" {  
   type = string
    default = "privatesubnet"
}