provider "azurerm" {
  features {}
}

#creating virtual network
resource "azurerm_virtual_network" "vn01" {
  name                = var.virtual_network_name
  address_space       = ["10.0.0.0/16"]
  location            = var.location
  resource_group_name = var.group_name
}

#Public subnet for vm
resource "azurerm_subnet" "public" {
  name                 = var.public_subnet_name
  resource_group_name  = var.group_name
  virtual_network_name = var.virtual_network_name
  address_prefixes     = ["10.0.1.0/24"]
}

#public ip for vm
resource "azurerm_public_ip" "app" {
  name                = "app-public-ip"
  location            = var.location
  resource_group_name = var.group_name
  allocation_method   = "Dynamic"
}

#Private subnet for db
resource "azurerm_subnet" "private" {
  name                 = var.private_subnet_name
  resource_group_name  = var.group_name
  virtual_network_name = var.virtual_network_name
  address_prefixes     = ["10.0.2.0/24"]
}

#security group rule for app
resource "azurerm_network_security_group" "public_nsg" {
  name                = "app-nsg"
  location            = var.location
  resource_group_name = var.group_name

  security_rule {
    name                       = "AllowAppFromInternet"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "Internet"
    destination_address_prefix = azurerm_subnet.private.address_prefixes[0]
  }

  security_rule {
    name                       = "DenyAllIncoming"
    priority                   = 2000
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_subnet_network_security_group_association" "public_subnet_association" {
  subnet_id                 = azurerm_subnet.public.id
  network_security_group_id = azurerm_network_security_group.public_nsg.id
}

#security group rule for db
resource "azurerm_network_security_group" "private_nsg" {
  name                = "db-nsg"
  location            = var.location
  resource_group_name = var.group_name

  security_rule {
    name                       = "AllowAppToDB"
    priority                   = 201
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3306"
    source_address_prefix      = module.app.app_subnet_cidr
    destination_address_prefix = azurerm_subnet.private.address_prefixes[0]
  }

  security_rule {
    name                       = "DenyAllIncoming"
    priority                   = 2000
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_subnet_network_security_group_association" "private" {
  subnet_id                 = azurerm_subnet.private.id
  network_security_group_id = azurerm_network_security_group.private_nsg.id
}