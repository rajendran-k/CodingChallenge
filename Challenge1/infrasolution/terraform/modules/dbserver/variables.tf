variable "group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "db_server" {
  type    = string
  default = "dev-db01"

}

variable "db_name" {
  type    = string
  default = "dev"
}
variable "version" {
  type    = string
  default = "12.0"
}
variable "db_naadministrator_username" {
  type    = string
  default = "sqladmin"
}
variable "administrator_login_password" {
  type      = string
  default   = "P@ssw0rd1234!"
  sensitive = true
}

variable "license_type" {
  type    = string
  default = "LicenseIncluded"

}
variable "max_size_gb" {
  type    = number
  default = 5
}
variable "read_scale" {
  type    = bool
  default = false
}
