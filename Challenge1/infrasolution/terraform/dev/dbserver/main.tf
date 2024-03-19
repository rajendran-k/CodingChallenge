module "db_module" {
    source = "../../modules/dbserver"    
    location         = var.location
    group_name =        var.group_name    
  
}