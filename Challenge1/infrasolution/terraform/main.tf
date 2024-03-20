provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "resource_group_dev" {
  name     = var.resource_group_name
  location = var.location
}

# Module for storage
module "storage" {
  source     = "./modules/storage"
  group_name = var.resource_group_name
  location   = var.location
}

# Module for networking
module "networking" {
  source     = "./modules/networking"
  group_name = var.resource_group_name
  location   = var.location
}

# Module for app
module "app" {
  source     = "./modules/app"
  location   = var.location
  group_name = var.resource_group_name
  subnet_id  = module.networking.private_subnet_id
  public_ip  = module.networking.azurerm_public_ip.app.ip
}

# Module for database
module "database" {
  source     = "./modules/dbserver"
  location   = var.location
  group_name = var.resource_group_name
}

output "app_public_ip" {
  value = module.app.app_public_ip
}

output "database_server_name" {
  value = module.database.database_server_name
}

output "database_name" {
  value = module.database.database_name
}