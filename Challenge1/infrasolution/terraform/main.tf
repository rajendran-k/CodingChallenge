provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "resource_group_dev" {
  name     = var.resource_group_name
  location = var.location
}

module "networking" {
  source = "./modules/storage"
  group_name     = var.resource_group_name
  location = var.location 
}

module "networking" {
  source = "./modules/networking"
  group_name     = var.resource_group_name
  location = var.location  
}

module "app" {
  source           = "./modules/app"
  location         = var.location
  group_name =  var.resource_group_name
  subnet_id        = module.networking.private_subnet_id
  public_ip = module.networking.azurerm_public_ip.app.ip  
}

module "database" {
  source           = "./modules/dbserver"
  location         = var.location
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