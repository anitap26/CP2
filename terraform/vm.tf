# Máquina Virtual en Azure
resource "azurerm_linux_virtual_machine" "vm_cp2" {
  name                  = "VM-CP2"
  location              = azurerm_resource_group.cp2.location
  resource_group_name   = azurerm_resource_group.cp2.name
  network_interface_ids = [azurerm_network_interface.vm_nic.id]
  size                  = "Standard_B1s"  # Tamaño estándar

  os_disk {
    name                 = "vm-cp2-osdisk"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
source_image_reference {
  publisher = "Canonical"
  offer     = "ubuntu-24_04-lts"
  sku       = "server"
  version   = "latest"
}

  computer_name                  = "vm-cp2"
  admin_username                  = "adminuser"
  disable_password_authentication = true

  admin_ssh_key {
    username   = "adminuser"
    public_key = file("~/.ssh/id_rsa.pub")
  }

  tags = {
    environment = "dev"
  }
}

# Interfaz de Red de la VM
resource "azurerm_network_interface" "vm_nic" {
  name                = "vm-cp2-nic"
  location            = azurerm_resource_group.cp2.location
  resource_group_name = azurerm_resource_group.cp2.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.vm_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.vm_public_ip.id
  }
}

# Dirección IP pública de la VM
resource "azurerm_public_ip" "vm_public_ip" {
  name                = "vm-cp2-public-ip"
  location            = azurerm_resource_group.cp2.location
  resource_group_name = azurerm_resource_group.cp2.name
  allocation_method   = "Dynamic"
}

# Asociación de la interfaz de red con el grupo de seguridad (NSG)
resource "azurerm_network_interface_security_group_association" "vm_nic_nsg" {
  network_interface_id      = azurerm_network_interface.vm_nic.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}
