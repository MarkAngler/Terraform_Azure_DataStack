resource "databricks_grants" "dbx_external_creds" {
  storage_credential = databricks_storage_credential.dbx_storage_creds.id
  grant {
    principal  = "DataEngineers"
    privileges = ["CREATE_EXTERNAL_TABLE"]
  }
}



resource "databricks_grants" "uc_we_d_sandbox" {
  catalog = databricks_catalog.uc_we_d_sandbox.name
  grant {
    principal  = "DataEngineers"
    privileges = ["ALL_PRIVILEGES"]
  }
}





resource "databricks_grants" "dbx_ext_storage" {
  external_location = databricks_external_location.dbx_ext_storage.id
  grant {
    principal  = "DataEngineers"
    privileges = ["ALL_PRIVILEGES"]
  }
}