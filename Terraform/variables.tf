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
  default     = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDCo8zxBGA2DQMo4CPKxu5b4DgvTpMc28hLQwiOWoGVag+iUcV+6/33dh1Cry7rvM8S2JPH88gOl2Nb7TpVDZtR/WNz9UsIb1n8vM8JpCB+yaI4q2+CTxqbmWjFFeWa5q0evg97VKnZI5kirdDem0y+Jgmm/+8zo2nb7YE6vTP9SU9Wzzkz9VBZHsG+7rnAvaw6/bzdG3A5O1Al1lTjyCJ3p3xTtvdxwcgLHpxhuV/7/VF2NHhV6WswbI7txi6F99dRMLjSmcY9g7fHI3qNWnlrRKctkWdH1/mQphhEzf+xnlwoLgNc9/toiT+3472NFeSSG/tdaNZUp16e/wHOEMKBJmeAvijpYkk/WFTxTh0i7RdPUc9rredutOU4DrMkxWl+fWAxHOosJonAF9IObBK+2e2aQ6AB/HX9j3lRH5qF1ig5+iUZB4oz1Krr3imVblHIVDzhLV8MT1T2gw+dblVJMH6diAUxwx9teeEiM0dMStY1IYWZXU+8dQttLMiremcAvW/Qs7nbfxt1S5NTraS+l2Zo09ssmVZVEbSXFjrweivgzLkqO76+2AbyeEGuq8azL0aDbnEJyKOySenUVYkpnoXcdQF0LPQSFHabtwH5qbsX+eKnsxlZZ/m6vydz6Kw2gUhLCSp0zyUy5GsK9+VXUB1ZpIlloU0nl9oXoqpAHw== david.ramon578@comunidadunir.net"
}