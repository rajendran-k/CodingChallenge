variable "group_name" {
  type = string
}

variable "vmname" {
  type    = string
  default = "vm"

}

variable "location" {
  type = string
}

variable "vm_count" {
  type    = number
  default = 2
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
  type      = string
  default   = "asdasdasdas"
  sensitive = true
}

variable "size" {
  type    = string
  default = "Standard_F2"
}