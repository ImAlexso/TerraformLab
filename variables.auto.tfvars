
#Configuracion general
subscription_id = "74b3227f-edf2-46c9-8a0c-797cf9a41d6b"
location        = "westeurope"
location_short  = "we"
environment     = "dev"
project_name    = "lab9263"

#Configuracion de red
vnet_address_space    = "10.0.0.0/16"
subnet_address_prefix = "10.0.1.0/24"

#Configuracion de la VM
vm_size           = "Standard_B1s"
vm_admin_username = "azureadmin"
#La contraseña que me la pidan por consola
# terraform plan -var="vm_admin_password="xxxxxx"