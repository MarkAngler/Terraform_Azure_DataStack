# data "databricks_spark_version" "latest_lts" {
#   long_term_support = true
#   depends_on = [azurerm_databricks_workspace.dbx]
# }

# data "databricks_node_type" "smallest" {
#   local_disk = true
#   depends_on = [azurerm_databricks_workspace.dbx]
# }



# resource "databricks_cluster" "shared_autoscaling" {
#   cluster_name            = "${var.region}-${var.environment}-shared"
#   spark_version           = data.databricks_spark_version.latest_lts.id
#   node_type_id            = data.databricks_node_type.smallest.id
#   autotermination_minutes = 20
#   autoscale {
#     min_workers = 1
#     max_workers = 2
#   }
  
# }