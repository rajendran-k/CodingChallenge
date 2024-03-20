provider "azurerm" {
  features {}
}

resource "azurerm_mssql_server" "db_server" {
  name                         = var.db_server
  resource_group_name          = var.group_name
  location                     = var.location
  version                      = var.version
  administrator_login          = var.db_naadministrator_username
  administrator_login_password = var.administrator_login_password
}

resource "azurerm_mssql_database" "db" {
  name         = var.db_name
  server_id    = azurerm_mssql_server.db_server.id
  collation    = "SQL_Latin1_General_CP1_CI_AS"
  license_type = var.license_type
  max_size_gb  = var.max_size_gb
  read_scale   = var.read_scale
}