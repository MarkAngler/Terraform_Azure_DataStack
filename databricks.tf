data "databricks_spark_version" "latest_lts" {
  long_term_support = true
  depends_on = [azurerm_databricks_workspace.dbx]
}
data "databricks_node_type" "smallest" {
  local_disk = true
  depends_on = [azurerm_databricks_workspace.dbx]
}








resource "azurerm_databricks_workspace" "dbx" {
  name                        = "${var.region}-${var.environment}-databricks-workspace"
  resource_group_name         = azurerm_resource_group.rg.name
  location                    = azurerm_resource_group.rg.location
  sku                         = "premium"
  managed_resource_group_name = "${var.region}-${var.environment}-databricks-workspace-rg"
}

resource "databricks_cluster" "shared_autoscaling" {
  cluster_name            = "${var.region}-${var.environment}-shared"
  spark_version           = data.databricks_spark_version.latest_lts.id
  node_type_id            = data.databricks_node_type.smallest.id
  autotermination_minutes = 20
  autoscale {
    min_workers = 1
    max_workers = 2
  }
  
}

resource "databricks_catalog" "uc_we_d_sandbox" {
  name    = "${var.region}_${var.environment}_sandbox"
  comment = "this catalog is managed by terraform"
  properties = {
    purpose = "dev sandbox"
  }
  depends_on = [azurerm_databricks_workspace.dbx, databricks_metastore_assignment.dbx_metastore_assignment]
}


resource "databricks_grants" "uc_we_d_sandbox" {
  catalog = databricks_catalog.uc_we_d_sandbox.name
  grant {
    principal  = "US_BACC"
    privileges = ["ALL_PRIVILEGES"]
  }
  grant {
    principal  = "DE_BACC"
    privileges = ["ALL_PRIVILEGES"]
  }
  grant {
    principal  = "CH_BACC"
    privileges = ["ALL_PRIVILEGES"]
  }
}


resource "azurerm_databricks_access_connector" "dbx_acd" {
  name                = "acd-databricks-${var.environment}-${var.region}-001"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location

  identity {
    type = "SystemAssigned"
  }
}

resource "databricks_storage_credential" "dbx_storage_creds" {
  name = "mi_credential"
  azure_managed_identity {
    access_connector_id = azurerm_databricks_access_connector.dbx_acd.id
  }
  depends_on = [databricks_metastore_assignment.dbx_metastore_assignment]
}

resource "databricks_grants" "dbx_external_creds" {
  storage_credential = databricks_storage_credential.dbx_storage_creds.id
  grant {
    principal  = "US_BACC"
    privileges = ["CREATE_EXTERNAL_TABLE"]
  }
}

resource "databricks_metastore_assignment" "dbx_metastore_assignment" {
  metastore_id = "894b0132-5fad-4509-afd8-d2850f2b76d3"
  workspace_id = azurerm_databricks_workspace.dbx.workspace_id
}

resource "databricks_external_location" "dbx_ext_storage" {
  name = "adls"
  url = format("abfss://%s@%s.dfs.core.windows.net",
  azurerm_storage_container.container_datalake.name,
  azurerm_storage_account.storageaccount.name)
  credential_name = databricks_storage_credential.dbx_storage_creds.id
  depends_on = [
    databricks_metastore_assignment.dbx_metastore_assignment
  ]
}


resource "databricks_grants" "dbx_ext_storage" {
  external_location = databricks_external_location.dbx_ext_storage.id
  grant {
    principal  = "US_BACC"
    privileges = ["ALL_PRIVILEGES"]
  }
  grant {
    principal  = "DE_BACC"
    privileges = ["ALL_PRIVILEGES"]
  }
  grant {
    principal  = "CH_BACC"
    privileges = ["ALL_PRIVILEGES"]
  }
}