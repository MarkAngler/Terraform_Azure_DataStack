

terraform {
  # backend "azurerm" {
  #   container_name       = "terraform"
  #   key                  = "databricks/terraform.tfstate"
  # }
  required_providers {
    databricks = {
      source  = "databricks/databricks"
      version = "1.35.0"
    }
      azurerm = {
      source = "hashicorp/azurerm"
      version = "3.89.0"
    }
  }
}

provider "azurerm" {
  features {}
}



# Use Azure CLI authentication.
data "databricks_current_user" "me" {
  depends_on = [azurerm_databricks_workspace.dbx]
}
provider "databricks" {
  host = azurerm_databricks_workspace.dbx.workspace_url
  
}


