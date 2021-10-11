terraform {
  required_version = ">= 1.0.0"
  required_providers {
    azurerm = {
        source = "hashicorp/azurerm"
        version = ">= 2.0"
    }
  }
}

provider "azurerm" {
    features {  
        virtual_machine {
          delete_os_disk_on_deletion = true
          
        }  
    } 
    alias = "provider-EASTUS"
  
}

provider "azurerm" {
    features {
      virtual_machine {
        delete_os_disk_on_deletion = false
      }
    }
  alias = "provider-WESTUS"
}