module "networking_module" {
    source = "../../modules/networking"    
    location         = var.location
    group_name =        var.group_name    
  
}