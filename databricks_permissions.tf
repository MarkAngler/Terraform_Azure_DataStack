# resource "databricks_grants" "grant_dbx_external_creds" {
#   storage_credential = databricks_storage_credential.stor_creds_dbx_acd.id
#   grant {
#     principal  = "DataEngineers"
#     privileges = ["ALL_PRIVILEGES"]
#   }
# }



# resource "databricks_grants" "grant_uc_development" {
#   catalog = databricks_catalog.uc_development.name
#   grant {
#     principal  = "DataEngineers"
#     privileges = ["ALL_PRIVILEGES"]
#   }
# }





# resource "databricks_grants" "grant_dbx_ext_storage" {
#   external_location = databricks_external_location.dbx_ext_storage_general.id
#   grant {
#     principal  = "DataEngineers"
#     privileges = ["ALL_PRIVILEGES"]
#   }
# }