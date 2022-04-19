
resource "azurerm_resource_group" "RG" {
  name     = var.RGname
  location = var.location
  tags     = var.tags
}

resource "azurerm_virtual_network" "VNET" {
  name                = join("", var.vnet)
  location            = azurerm_resource_group.RG.location
  resource_group_name = azurerm_resource_group.RG.name
  address_space       = [element(var.address_space, 0)]
}

resource "azurerm_subnet" "subnet-env-1" {
  name                 = "subnet-env-1"
  virtual_network_name = azurerm_virtual_network.VNET.name
  resource_group_name  = azurerm_resource_group.RG.name
  address_prefixes     = [element(var.address_space, 2)]
}

resource "azurerm_subnet" "subnet-env-2" {
  name                 = "subnet-env-2"
  virtual_network_name = azurerm_virtual_network.VNET.name
  resource_group_name  = azurerm_resource_group.RG.name
  address_prefixes     = [element(var.address_space, 3)]
}
/*
resource "azurerm_public_ip" "PIP" {
  count               = 1
  name                = "PIP-${count.index}"
  resource_group_name = azurerm_resource_group.RG.name
  allocation_method   = "Static"
  location            = azurerm_resource_group.RG.location
}*/

resource "azurerm_network_interface" "NIC-env-1" {
  count               = 2
  name                = "NIC-env-1-${count.index}"
  resource_group_name = azurerm_resource_group.RG.name
  location            = azurerm_resource_group.RG.location


  ip_configuration {

    name                          = "ipconfig"
    subnet_id                     = count.index == 0 ? azurerm_subnet.subnet-env-1.id : azurerm_subnet.subnet-env-2.id
    private_ip_address_allocation = "Dynamic"
    #public_ip_address_id          = element(azurerm_public_ip.PIP.*.id, count.index)
  }
}

resource "azurerm_network_interface" "NIC-env-2" {
  count               = 2
  name                = "NIC-env-2-${count.index}"
  resource_group_name = azurerm_resource_group.RG.name
  location            = azurerm_resource_group.RG.location


  ip_configuration {

    name                          = "ipconfig"
    subnet_id                     = count.index == 0 ? azurerm_subnet.subnet-env-1.id : azurerm_subnet.subnet-env-2.id
    private_ip_address_allocation = "Dynamic"
    #public_ip_address_id          = element(azurerm_public_ip.PIP.*.id, count.index)
  }
}
#resource "random_password" "password" {
#  length           = 8
#  special          = true
#}

resource "azurerm_network_security_group" "NSG" {

  name                = "TF-NSG"
  location            = azurerm_resource_group.RG.location
  resource_group_name = azurerm_resource_group.RG.name

  security_rule {
    name                       = "SSH"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  security_rule {
    name                       = "RDP"
    priority                   = 101
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}
resource "azurerm_subnet_network_security_group_association" "subnet-association-with-NSG-env-1" {
  subnet_id                 = azurerm_subnet.subnet-env-1.id
  network_security_group_id = azurerm_network_security_group.NSG.id
}

resource "azurerm_subnet_network_security_group_association" "subnet-association-with-NSG-env-2" {
  subnet_id                 = azurerm_subnet.subnet-env-2.id
  network_security_group_id = azurerm_network_security_group.NSG.id
}


resource "azurerm_windows_virtual_machine" "Windows-VM" {

  count                 = 2
  name                  = "TF-env-1-${count.index}"
  resource_group_name   = azurerm_resource_group.RG.name
  location              = azurerm_resource_group.RG.location
  network_interface_ids = [element(azurerm_network_interface.NIC-env-1.*.id, count.index)]
  size                  = "Standard_B2ms"

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }

  os_disk {
    name                 = "TF-Disk-env-1-${count.index}"
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }

  computer_name  = "TF-env-1-${count.index}"
  admin_username = var.username
  admin_password = var.passwd

}

resource "azurerm_linux_virtual_machine" "linux-vm" {

  count                 = 2
  name                  = "TF-env-2-${count.index}"
  resource_group_name   = azurerm_resource_group.RG.name
  location              = azurerm_resource_group.RG.location
  size                  = "Standard_DS1_v2"
  admin_username        = var.username
  network_interface_ids = [element(azurerm_network_interface.NIC-env-2.*.id, count.index)]
  admin_password        = var.passwd

  disable_password_authentication = false

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
    name                 = "TF-Disk-env-2-${count.index}"
  }

  source_image_reference {
    publisher = "RedHat"
    offer     = "RHEL"
    sku       = "83-gen2"
    version   = "latest"
  }

  #custom_data = filebase64("${path.module}/app-scripts/app1-cloud-init.txt")

}
