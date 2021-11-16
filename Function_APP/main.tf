
provider "azurerm" {
  features {}
}

locals {
  tags = {
    eonid         = var.eonid
    created       = formatdate("DD MM YYYY hh:mm ZZZ", timestamp())
    owner_contact = var.owner_contact
  }
  rg_name               = format("eon%s-%s-%s-rg", var.eonid, lookup(var.region_short_code, var.location), var.name)
  app_service_plan_name = format("eon%s%s", var.eonid, var.app_service_plan)
  function_app_name        = format("eon%s%s", var.eonid, var.name)
  basename              = format("%s%s%s", var.eonid, lower(var.name), local.region_short_code)
  region_short_code     = lookup(var.region_short_code, var.location)
}

resource "azurerm_resource_group" "RG" {

  lifecycle {
    ignore_changes = [tags, ]
  }
  name     = local.rg_name
  location = var.location
  tags     = local.tags
}


resource "azurerm_storage_account" "storage_account" {

  lifecycle {
    ignore_changes = [tags, ]
  }
  name                     = local.basename
  resource_group_name      = azurerm_resource_group.RG.name
  location                 = var.location
  account_tier             = var.tier
  account_replication_type = var.replication
  tags = local.tags

}


resource "azurerm_app_service_plan" "app-plan" {

  lifecycle {
    ignore_changes = [tags, ]
  }
  name                = local.app_service_plan_name
  resource_group_name = azurerm_resource_group.RG.name
  location            = var.location
  reserved            = true
  kind                = var.App_kind
  tags                = local.tags

  sku {
    tier     = var.sku_tier
    size     = var.sku_size
    capacity = 5
  }
  timeouts {
    create = "3h"
    update = "2h"
    delete = "1h"
  }
}

resource "azurerm_function_app" "function" {
  name                       = local.function_app_name
  location                   = var.location
  resource_group_name        = azurerm_resource_group.RG.name
  app_service_plan_id        = azurerm_app_service_plan.app-plan.id
  storage_account_name       = azurerm_storage_account.storage_account.name
  storage_account_access_key = azurerm_storage_account.storage_account.primary_access_key
  os_type                    = "linux"
  version                    = "~3"
}