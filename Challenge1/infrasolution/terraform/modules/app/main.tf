provider "azurerm" {
  features {}
}

resource "azurerm_network_interface" "interface" {
  name                = "app-nic"
  location            = var.location
  resource_group_name = var.group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
  }
  ip_configuration {
    name                          = "public"
    subnet_id                     = var.subnet_id 
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = var.public_ip
  }
}

resource "azurerm_windows_virtual_machine" "appserver" {
  name                = "appserver"
  resource_group_name = var.group_name
  location            = var.location
  size                = var.size
  admin_username      = "adminuser"
  admin_password      = var.password
  network_interface_ids = [
    azurerm_network_interface.interface.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }
}

