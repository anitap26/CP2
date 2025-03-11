# Grupo de Seguridad (NSG)
resource "azurerm_network_security_group" "nsg" {
  name                = "cp2-nsg"
  location            = azurerm_resource_group.cp2.location
  resource_group_name = azurerm_resource_group.cp2.name
}

# Regla para permitir SSH (22) y HTTP (80)
resource "azurerm_network_security_rule" "allow_ssh_http" {
  name                        = "allow-ssh-http"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_ranges     = ["22", "80"]
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.cp2.name
  network_security_group_name = azurerm_network_security_group.nsg.name
}

# Asociar NSG a la subnet de la VM
resource "azurerm_subnet_network_security_group_association" "vm_nsg_assoc" {
  subnet_id                 = azurerm_subnet.vm_subnet.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}
