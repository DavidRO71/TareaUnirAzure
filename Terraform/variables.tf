variable "subscription_id" {
  description = "ID de la suscripción"
  type        = string
  default     = "d3535dc1-cdc5-4932-abad-4cf8d2ad675a" 
}

variable "client_id" {
  description = "ID de cliente"
  type        = string
  default     = "Azure for Students"
}

variable "tenant_id" {
  description = "ID de tenant"
  type        = string
  default     = "899789dc-202f-44b4-8472-a6d40f9eb440"
}

variable "resource_group_name" {
  description = "El nombre del grupo de recursos"
  type        = string
  default     = "davidrgn"
}

variable "resource_group_location" {
  description = "La localizacion donde se crearan mis recursos"
  type        = string
  default     = "Spain Central"
}

variable "azurerm_container_registry" {
  description = "El nombre de mi ACR"
  type        = string
  default     = "davidacr"
}

variable "location_container_registry" {
  description = "La localizacion de mi ACR"
  type        = string
  default     = "Spain Central"
}

variable "admin_ssh_key" {
  description = "Clave SSH pública para poder acceder a la maquina virtual"
  type        = string
  default     = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCsVguYOG6nM6y/JzoJVS+ijwqsyWgbz5XdGo46A3jzUU86Z/stlpZpSczdORrX7ovyF/CZfV9Kw/EFN8hMotPOq7uEDMmyHOrTsP8gOCrejV5iuVeRfTe3h8A7m6N8co5A+XZjRBi6U+ohQ/SyO1vpNteJy660SSFC1MngM6mslzA9bqi0wKiZTg+YYTbLihyqene6lrM8MPBmYPl4Sp4cnGL/2a7EC/Cc+JJl+aJ87swyne6OK5mS3B/v4T875YHp1OmqM05e87SLzD2OjrXK9Moep7vGRWOQeg8qTfkvPFlPgVszOqBBCZbh5HUisDB3CNk3OYFrMXyZt4mGr0jq77FgevS6X1M/CL441uTeEaDahBZn7BfzMghACiIEOQynHWtt+xrkYWpz0/Pt5lUBTAtqT0GwY51WI81/EJW3nFmia0lrgXXSmD1pwqMe5MNIwGZnGU0grHyBKnghxAvhKOPlkDef2IKjqVuaRRJzAm+EKAYmf1GmhSLaV/JODATsI8DbLbU+qkF+4+a/ID2yy3TP/xczJO6HEyopdANymcHi8uUZKOBEpgM8giXIOzSR6GbHOqx97an/XABhdh8KYhTwy6Io6ZN99SUV768xeKGyMQLsGiY7c/cLmG1w0gUTrty37cxD/VgrYeglcx4SVxTJNhcferCcwfdPPxIKow=="
}