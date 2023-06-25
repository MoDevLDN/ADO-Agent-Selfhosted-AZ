# Resource Group
resource "azurerm_resource_group" "moado" {
  name     = var.rg_name
  location = var.location
}