terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.81.0"
    }
  }


  cloud {
    
    organization = "ntms-org"

    workspaces {
      name = "ntms-terraform-workshop-4"
    }
  }
}

provider "azurerm" {
  # Configuration options
  features {

  }
}

