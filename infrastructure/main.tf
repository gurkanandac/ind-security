resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.resource_group_location
}

resource "azurerm_network_security_group" "nsg" {
  name                = "example-security-group"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_virtual_network" "vn" {
  name                = "example-network"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = ["10.0.0.0/16"]

  subnet {
    name             = "subnet1"
    address_prefix = "10.0.2.0/24"
    security_group   = azurerm_network_security_group.nsg.id
  }

  tags = {
    environment = "Production"
  }
}