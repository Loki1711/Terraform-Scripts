variable "RGname" {
  description = "This is the name for the RG"
}

variable "location" {
  description = "This is the location for the RG"
}


variable "tags" {
  type = map(any)
}

variable "AKS-name" {}
variable "log_analytics_workspace_sku" {
  default = "PerGB2018"
}

variable "dns_prefix" {}
variable "log_analytics_workspace_name" {
  default = "testLogAnalyticsWorkspaceName"
}