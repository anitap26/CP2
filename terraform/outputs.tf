# IP pública de la VM (para acceso SSH y HTTP)
output "vm_public_ip" {
  description = "Dirección IP pública de la máquina virtual"
  value       = azurerm_public_ip.vm_public_ip.ip_address
}

# IP privada de la VM dentro de la VNet
output "vm_private_ip" {
  description = "Dirección IP privada de la máquina virtual"
  value       = azurerm_network_interface.vm_nic.private_ip_address
}

# Nombre del grupo de recursos donde se han desplegado los servicios
output "resource_group_name" {
  description = "Nombre del Resource Group"
  value       = azurerm_resource_group.cp2.name
}

# Nombre y URL del Azure Container Registry (ACR)
output "acr_name" {
  description = "Nombre del Azure Container Registry"
  value       = azurerm_container_registry.acrCP2_UNIR.name
}

output "acr_login_server" {
  description = "URL del ACR para hacer login y subir imágenes"
  value       = azurerm_container_registry.acrCP2_UNIR.login_server
}

# Información sobre la red virtual y las subnets
output "vnet_name" {
  description = "Nombre de la Virtual Network"
  value       = azurerm_virtual_network.vnet.name
}

output "vm_subnet_id" {
  description = "ID de la Subnet de la VM"
  value       = azurerm_subnet.vm_subnet.id
}

output "vnet_address_space" {
  description = "Espacio de direcciones de la Virtual Network"
  value       = azurerm_virtual_network.vnet.address_space
}

output "aks_name" {
  value = azurerm_kubernetes_cluster.aks_cp2.name
}

output "aks_kubeconfig" {
  value     = azurerm_kubernetes_cluster.aks_cp2.kube_config_raw
  sensitive = true
}
