
resource "azurerm_resource_group" "RG" {
  name             = var.RGname
  location         = var.location
  tags = var.tags
}

resource "azurerm_kubernetes_cluster" "AKS" {
  name                = var.AKS-name
  location            = azurerm_resource_group.RG.location
  resource_group_name = azurerm_resource_group.RG.name
  dns_prefix          = "demoaks1"

  default_node_pool {
    name       = "default"
    node_count = 2
    vm_size    = "Standard_DS2_v2"
  }

  identity {
    type = "SystemAssigned"
  }

   network_profile {
    load_balancer_sku = "Standard"
    network_plugin    = "azure"
  }

  tags = var.tags
}