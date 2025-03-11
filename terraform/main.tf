terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
  }
  required_version = ">= 1.3.0"
}

provider "azurerm" {
  features {}
  subscription_id = "d0fbb041-9d15-421f-bc12-6eeb5dfb0b5b"
}

# Creación del Resource Group
resource "azurerm_resource_group" "cp2" {
  name     = var.resource_group_name
  location = var.location
}

# Generar un sufijo aleatorio para evitar conflictos con nombres repetidos
resource "random_string" "suffix" {
  length  = 6
  special = false
  upper   = false
}

# Creación del Azure Container Registry (ACR) con un nombre único
resource "azurerm_container_registry" "acrCP2_UNIR" {
  name                = "${var.acr_name}${random_string.suffix.result}"  # Nombre único
  resource_group_name = azurerm_resource_group.cp2.name
  location            = azurerm_resource_group.cp2.location
  sku                 = "Basic"
  admin_enabled       = true
}
# Creación del Clúster de Kubernetes (AKS)
resource "azurerm_kubernetes_cluster" "aks_cp2" {
  name                = var.aks_name
  location            = azurerm_resource_group.cp2.location
  resource_group_name = azurerm_resource_group.cp2.name
  dns_prefix          = var.aks_name

  default_node_pool {
    name       = "default"
    node_count = var.node_count
    vm_size    = var.vm_size
  }

  identity {
    type = "SystemAssigned"
  }

  role_based_access_control_enabled = true

}