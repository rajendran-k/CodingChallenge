module "app_module" {
    source = "../../modules/app"    
    location         = var.location
    group_name =        var.group_name
    subnet_id        = module.networking.private_subnet_id
    public_ip = module.networking.azurerm_public_ip.app.ip    
  
}