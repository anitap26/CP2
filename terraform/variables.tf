# Nombre del grupo de recursos
variable "resource_group_name" {
  description = "Nombre del Resource Group donde se desplegará la infraestructura"
  type        = string
  default     = "CP2"
}

# Ubicación en Azure
variable "location" {
  description = "Región de Azure donde se crearán los recursos"
  type        = string
  default     = "West Europe"
}

# Nombre del Azure Container Registry (ACR)
variable "acr_name" {
  description = "Nombre del registro de contenedores en Azure"
  type        = string
  default     = "cp2acr"
}

# Nombre de la Virtual Network (VNet)
variable "vnet_name" {
  description = "Nombre de la Virtual Network"
  type        = string
  default     = "cp2-vnet"
}

# Rango de direcciones de la VNet
variable "vnet_address_space" {
  description = "Rango de direcciones IP para la Virtual Network"
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

# Subnet para la VM
variable "vm_subnet_name" {
  description = "Nombre de la Subnet de la VM"
  type        = string
  default     = "vm-subnet"
}

variable "vm_subnet_prefix" {
  description = "Prefijo de la Subnet de la VM"
  type        = list(string)
  default     = ["10.0.1.0/24"]
}

# Subnet para AKS
variable "aks_subnet_name" {
  description = "Nombre de la Subnet para AKS"
  type        = string
  default     = "aks-subnet"
}

variable "aks_subnet_prefix" {
  description = "Prefijo de la Subnet de AKS"
  type        = list(string)
  default     = ["10.0.2.0/24"]
}

# Nombre AKS
variable "aks_name" {
  type    = string
  default = "aks-cp2"
}

# Nodos
variable "node_count" {
  type    = number
  default = 2
}

# Tamaño AKS
variable "vm_size" {
  type    = string
  default = "Standard_DS2_v2"
}