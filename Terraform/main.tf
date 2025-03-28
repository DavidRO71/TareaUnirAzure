terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 4.21.1"
    }
  }
}

# Configuración del proveedor de Azure
provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
#  client_id       = var.client_id
#  tenant_id       = var.tenant_id
}

# Creación de un grupo de recursos
resource "azurerm_resource_group" "arg" {
  name     = var.resource_group_name
  location = var.resource_group_location
}

# Creación de una red virtual
resource "azurerm_virtual_network" "avnet" {
  name                = "miAvnet"
  location            = azurerm_resource_group.arg.location
  resource_group_name = azurerm_resource_group.arg.name
  address_space       = ["10.0.0.0/16"]
}

# Creación de una subred automáticamente
resource "azurerm_subnet" "asubnet" {
  name                 = "miAsubnet"
  resource_group_name  = azurerm_resource_group.arg.name
  virtual_network_name = azurerm_virtual_network.avnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

# Creación del Azure Container Registry (ACR)
resource "azurerm_container_registry" "acr" {
  name                  = var.azurerm_container_registry
  location              = var.location_container_registry
  resource_group_name   = var.resource_group_name
  sku                   = "Basic"
  admin_enabled         = true
}

# Creación de el clúster de Kubernetes (AKS)
resource "azurerm_kubernetes_cluster" "aks" {
  name                = "miAKS"
  location            = azurerm_resource_group.arg.location
  resource_group_name = azurerm_resource_group.arg.name
  dns_prefix          = "myaks"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_B2s"
  }

  identity {
    type = "SystemAssigned"
  }
}

# Creación de la IP pública dinámica
resource "azurerm_public_ip" "apublic_ip" {
  name                         = "miIPPublic"
  location                     = azurerm_resource_group.arg.location
  resource_group_name          = azurerm_resource_group.arg.name
  allocation_method            = "Static"
  sku                          = "Basic"
  tags = {
    environment = "dev"
  }
}

# Creación de una interfaz de red para la VM
resource "azurerm_network_interface" "anic" {
  name                      = "anic-ubuntu"
  location                  = var.resource_group_location
  resource_group_name       = var.resource_group_name
  # Configuración de la IP
  ip_configuration {
    name                          = "miIPConf"
    subnet_id                     = azurerm_subnet.asubnet.id
    public_ip_address_id          = azurerm_public_ip.apublic_ip.id
    private_ip_address_allocation = "Dynamic"
  }

  depends_on = [azurerm_public_ip.apublic_ip]
}


# Creación de una máquina virtual Ubuntu
resource "azurerm_linux_virtual_machine" "avml" {
  name                = "avml-ubuntu"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  size                = "Standard_B1s"
  admin_username      = "ubuntuadmin"
  #admin_password      = "miContraseñaAzure"
  disable_password_authentication = true
  network_interface_ids = [azurerm_network_interface.anic.id]

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  # Definir el disco del sistema operativo
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  # Usar la clave SSH
  admin_ssh_key {
    username   = "ubuntuadmin"
    public_key = var.admin_ssh_key
  }
  
  tags = {
    environment = "dev"
  }
										   
}

#-------------------------------------------
# Asignación de los permisos
resource "azurerm_role_assignment" "acr_owner" {
  principal_id          = azurerm_kubernetes_cluster.aks.identity[0].principal_id
  role_definition_name  = "Owner"  # Asigno el rol con los permisos completos
  scope                  = azurerm_container_registry.acr.id
}

# Configuración del grupo de seguridad de red (NSG) para habilitar SSH
resource "azurerm_network_security_group" "ansg" {
  name                = "ansg-test"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name

  # Dependencias
  depends_on = [azurerm_resource_group.arg]

  security_rule {
    name                       = "AllowSSH"
    priority                   = 1000
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  security_rule {
    name                       = "AllowTCP"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

#-------------------------------------------
# Variables de salida
output "public_ip" {
  value       = azurerm_public_ip.apublic_ip.ip_address
  description = "Salida para mostrar mi IP pública y dinámica de la máquina virtual"
}

# Salidas para el ACR
output "acr_name" {
  value = azurerm_container_registry.acr.name
  description = "Salida para mostrar el nombre de mi ACR"
}

output "aks_name" {
  value       = azurerm_kubernetes_cluster.aks.name
  description = "Salida para mostrar el nombre de mi AKS"
}