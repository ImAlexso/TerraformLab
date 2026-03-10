# ────────────────────────────────────────────────────────────────
# Variables generales
# ────────────────────────────────────────────────────────────────

variable "subscription_id" {
  description = "ID de la suscripción de Azure donde se crearán los recursos"
  type        = string
}

variable "location" {
  description = "Región de Azure donde se desplegarán los recursos (ej: westeurope, northeurope)"
  type        = string
  default     = "westeurope"
}

variable "location_short" {
  description = "Abreviatura de location para estandarizar nombre"
  type        = string
}

variable "environment" {
  description = "Nombre del entorno: dev, pre o pro"
  type        = string

  # Validación: solo permite estos 3 valores
  validation {
    condition     = contains(["dev", "pre", "pro"], var.environment)
    error_message = "El entorno debe ser: dev, pre o pro."
  }
}

variable "project_name" {
  description = "Nombre corto del proyecto (se usará como prefijo en todos los recursos)"
  type        = string
}

# ────────────────────────────────────────────────────────────────
# Variables de red (VNet + Subnet)
# ────────────────────────────────────────────────────────────────

variable "vnet_address_space" {
  description = "Rango de IPs de la VNet en formato CIDR (ej: 10.0.0.0/16)"
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnet_address_prefix" {
  description = "Rango de IPs de la Subnet en formato CIDR (ej: 10.0.1.0/24) - debe estar DENTRO del rango de la VNet"
  type        = string
  default     = "10.0.1.0/24"
}

# ────────────────────────────────────────────────────────────────
# Variables de la VM
# ────────────────────────────────────────────────────────────────

variable "vm_size" {
  description = "Tamaño de la VM (define CPU, RAM, disco). Standard_B1s es el más barato."
  type        = string
  default     = "Standard_B1s"
}

variable "vm_admin_username" {
  description = "Nombre del usuario administrador de la VM"
  type        = string
  default     = "azureadmin"
}

variable "vm_admin_password" {
  description = "Contraseña del administrador de la VM (mínimo 12 caracteres, con mayúscula, minúscula, número y símbolo)"
  type        = string
  sensitive   = true # 🔒 "sensitive" oculta el valor en los logs de Terraform
}
