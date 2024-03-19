terraform {

  backend "azurerm" {
    resource_group_name  = var.group_name
    storage_account_name = "your_storage_account_name"
    container_name       = "your_container_name"
    key                  = "terraform.tfstate"
  }
}
