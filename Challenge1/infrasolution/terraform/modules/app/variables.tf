variable "group_name" {
    type = string
}

variable "location" {  
  type = string
}

variable "subnet_id" {  
  type = string
}

variable "subnet_id" {  
  type = string
}
variable "public_ip" {  
  type = string
}

variable "password" {  
  type = string
  default = "asdasdasdas"
  sensitive = true
}
variable "size" {  
  type = string
  default = "Standard_F2"
  
}