resource "databricks_grants" "dbx_external_creds" {
  storage_credential = databricks_storage_credential.dbx_storage_creds.id
  grant {
    principal  = "DataEngineers"
    privileges = ["CREATE_EXTERNAL_TABLE"]
  }
}