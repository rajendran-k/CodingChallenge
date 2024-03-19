output "app_public_ip" {
  value = module.app.app_public_ip
}

output "database_server_name" {
  value = azurerm_mssql_server.example.name
}

output "database_name" {
  value = azurerm_mssql_database.example.name
}
