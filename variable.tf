variable "eonid" {
  type    = string
  default = "101tf"
}

variable "owner_contact" {
  type    = string
  default = "lokesh_kumar"
}
variable "location" {
  type    = string
  default = "centralus"
}
variable "region_short_code" {

  default = {
    eastus2   = "use2"
    eastus    = "use"
    centralus = "usc"
  }
}

variable "name" {
  type    = string
  default = "functionapp"
}


variable "tier" {
  description = "Account Tier for the Storage Account"
  default     = "Standard"
}

variable "replication" {
  description = "Account Replication Type for the Storage Account"
  default     = "LRS"
}

variable "kind" {
  type    = string
  default = "FileStorage"
}

variable "app_service_plan" {
  default = "appserviceplan"
}
variable "App_kind" {
  type    = string
  default = "Linux"
}

variable "sku_tier" {
  description = "SKU Tier for the App Service Plan"
  default     = "Dynamic"
}

variable "sku_size" {
  description = "SKU Size for the App Service Plan"
  default     = "Y1"
}


variable "app_settings" {
  description = "App Setting for the Logic App"
  default = {
    "FUNCTIONS_WORKER_RUNTIME" : "node"
    "WEBSITE_NODE_DEFAULT_VERSION" : "~12"
  }
}


