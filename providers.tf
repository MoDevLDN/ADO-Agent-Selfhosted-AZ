# Terraform Block
terraform {
  required_version = ">= 1.5.0"
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = ">= 3.62.1" 
    }
    random = {
      source = "hashicorp/random"
      version = ">= 3.5.1"
    }
  }
}

# Provider Block
provider "azurerm" {
 features {}          
}
