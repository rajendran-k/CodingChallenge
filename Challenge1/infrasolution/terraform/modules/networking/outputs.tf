output "private_subnet_id" {
  value = azurerm_subnet.private.id
}

output "public_ip_address_id" {
  value = azurerm_public_ip.app.id
}