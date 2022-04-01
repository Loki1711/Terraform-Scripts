
resource "azurerm_resource_group" "RG" {
  name     = var.RGname
  location = var.location
  tags     = var.tags
}

resource "azurerm_virtual_network" "VNET" {
  count               = length(var.address_space)
  name                = lookup(element(var.address_space, count.index), "name")
  location            = var.location
  resource_group_name = azurerm_resource_group.RG.name
  address_space       = [lookup(element(var.address_space, count.index), "ip")]
  tags                = var.tags
}

resource "azurerm_subnet" "subnet" {
  count                = length(var.subnet_prefixes)
  name                 = lookup(element(var.subnet_prefixes, count.index), "name")
  resource_group_name  = azurerm_resource_group.RG.name
  virtual_network_name = lookup(element(azurerm_virtual_network.VNET, count.index), "name")
  address_prefixes     = [lookup(element(var.subnet_prefixes, count.index), "ip")]

}
