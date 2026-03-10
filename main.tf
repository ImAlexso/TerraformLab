# ════════════════════════════════════════════════════════════════
# Locals: variables calculadas que usamos internamente
# ════════════════════════════════════════════════════════════════

locals {
  # Construimos los nombres siguiendo la convención:
  # tipo-proyecto-entorno-region
  # Ejemplo: rg-miproyecto-dev-we
  suffix = "${var.project_name}-${var.environment}-${var.location_short}"
}

# Create a resource group
resource "azurerm_resource_group" "rg" {
  name     = "rg-${local.suffix}"
  location = var.location
  # Tags: etiquetas para organizar y filtrar recursos en Azure
  tags = {
    environment = var.environment
    project     = var.project_name
    managed_by  = "terraform"
  }
}
# Create a Vnet
resource "azurerm_virtual_network" "vnet" {
  name                = "vnet-${local.suffix}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = [var.vnet_address_space]

  tags = azurerm_resource_group.rg.tags
}
#create a SubNet
resource "azurerm_subnet" "subnet" {
  name                 = "subnet-${local.suffix}"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.subnet_address_prefix]
}
#create a NIC for de VM
resource "azurerm_network_interface" "nic" {
  name                = "nic-${local.suffix}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "vm" {
  name                = "vm-${local.suffix}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  size                = var.vm_size

  admin_username                  = var.vm_admin_username
  admin_password                  = var.vm_admin_password
  disable_password_authentication = false

  network_interface_ids = [azurerm_network_interface.nic.id]

  os_disk {
    name                 = "osdisk-${local.suffix}"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  tags = azurerm_resource_group.rg.tags
}