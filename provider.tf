terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.81.0"
    }
  }


  cloud {
    
    organization = "sunil-ntms-org"

    workspaces {
      name = "sunil-ntms-terraform-workshop-4"
    }
  }
}

provider "azurerm" {
  # Configuration options
  features {

  }
}

