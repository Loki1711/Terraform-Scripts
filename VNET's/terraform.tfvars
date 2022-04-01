
subscription_id = "Replace"
client_id       = "Replace"
client_secret   = "Replace"
tenant_id       = "Replace"
location        = "Central India"
RGname          = "VNET-RG"
tags            = { Owner = "Loki", Environment = "demo" }
vnet            = ["TF-", "VNET"]
NSG             = ["TF-", "NSG"]
address_space = [
  {
    ip   = "10.0.0.0/16"
    name = "VNET-1"
  },
  {
    ip   = "192.168.0.0/16"
    name = "VNET-2"
  },
  {
    ip   = "172.16.0.0/16"
    name = "VNET-3"
  }
]
subnet_prefixes = [

  {
    ip   = "10.0.1.0/24"
    name = "TF1-subnet-1"
  },
  {
    ip   = "192.168.1.0/24"
    name = "TF2-subnet-1"
  },
  {
    ip   = "172.16.1.0/24"
    name = "TF3-subnet-1"
  },
  {
    ip   = "10.0.2.0/24"
    name = "TF1-subnet-2"
  },
  {
    ip   = "192.168.2.0/24"
    name = "TF2-subnet-2"
  },
  {
    ip   = "172.16.2.0/24"
    name = "TF3-subnet-2"
  },
  {
    ip   = "10.0.3.0/24"
    name = "TF1-subnet-3"
  },
  {
    ip   = "192.168.3.0/24"
    name = "TF2-subnet-3"
  },
  {
    ip   = "172.16.3.0/24"
    name = "TF3-subnet-3"
  }
]


rules = [
  {
    name                       = "rule-1"
    priority                   = 101
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  },
  {
    name                       = "rule-2"
    priority                   = 102
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  },
  {
    name                       = "rule-3"
    priority                   = 103
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
]
