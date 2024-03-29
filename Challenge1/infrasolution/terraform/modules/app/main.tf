provider "azurerm" {
  features {}
}

resource "azurerm_public_ip" "lb_ip_address" {
  name                = "PublicIPForLB"
  location            = var.location
  resource_group_name = var.group_name
  allocation_method   = "Static"
}

#creating load balancer
resource "azurerm_lb" "app_lb" {
  name                = "my-app-lb"
  location            = var.location
  resource_group_name = var.group_name
  frontend_ip_configuration {
    name                 = "PublicIPAddress"
    public_ip_address_id = azurerm_public_ip.lb_ip_address.id
  }
}

#backend pool
resource "azurerm_lb_backend_address_pool" "app_pool" {
  name                = "my-app-pool"
  loadbalancer_id = azurerm_lb.app_lb.id
}

#connecting to vm to the backend address
resource "azurerm_network_interface_backend_address_pool_association" "vm1" {
  network_interface_id    = azurerm_network_interface.interface.id
  ip_configuration_name   = "test config1"
  backend_address_pool_id = azurerm_lb_backend_address_pool.app_pool.id
}

#connecting to vm to the backend address
resource "azurerm_network_interface_backend_address_pool_association" "vm2" {
  network_interface_id    = azurerm_network_interface.interface.id
  ip_configuration_name   = "test config2"
  backend_address_pool_id = azurerm_lb_backend_address_pool.app_pool.id
}

resource "azurerm_lb_rule" "app_rule" {
  name                           = "allow_http"
  loadbalancer_id                = azurerm_lb.app_lb.id
  frontend_ip_configuration_name = "PublicIPAddress"
  frontend_port                  = 80
  backend_port                   = 80
  protocol                       = "Tcp"
}

resource "azurerm_network_interface" "interface" {
  name                = "app-nic"
  location            = var.location
  resource_group_name = var.group_name
  count               = 2

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
  }
}

#vm creation
resource "azurerm_virtual_machine" "appserver" {
  name                = var.vmname
  resource_group_name = var.group_name
  location            = var.location
  vm_size             = var.size
  count               = var.vm_count
  network_interface_ids = [
    azurerm_network_interface.interface.id,
  ]

  os_profile {
    computer_name  = format("app-vm-%d", count.index)
    admin_username = "adminuser"
    admin_password = var.password
  }

  storage_os_disk {
    name          = "osdisk"
    caching       = "ReadWrite"
    create_option = "FromImage"
    image_uri     = "marketplace.microsoft.com/images/ubuntu-latest:LTS"
  }
}

