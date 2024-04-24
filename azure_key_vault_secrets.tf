
resource "random_string" "key_vault_random_secret" {
  length  = 13
  lower   = true
  numeric = true
  special = true
  upper   = true
}

resource "azurerm_key_vault_secret" "sql_administrator_login" {
  name         = "sql-administrator-login"
  value        = random_string.key_vault_random_secret.result
  key_vault_id = azurerm_key_vault.keyvault.id

  
}