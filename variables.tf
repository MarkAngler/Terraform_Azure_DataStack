variable "environment" {
  type    = string
  default = "d"
}

variable "region" {
  type = string
  default = "centralus"
}

# variable "policy_job_compute" {
#   type    = string
#   default = "60632A6776000707"
# }


variable "dltDevelopmentMode" {
  type = bool
  default = false
}

variable "stihlAnalyticsWebhookId" {
  type = string
  default = ""
}

variable "discordWebhookId" {
  type = string
  default = ""
}



# variable "devops_client_id" {
#   type        = string
#   sensitive   = true
# }

# variable "devops_client_secret" {
#   type        = string
#   sensitive   = true
# }