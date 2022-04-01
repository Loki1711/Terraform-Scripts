
subscription_id = "10f021df-9c00-42b7-9363-79a3800d1c70"
client_id       = "051a0b07-42d4-4016-89cb-1d4126cee396"
client_secret   = "Puo_PQTC5jC0fiTcRoO25YG_H_D.d2a5Yt"
tenant_id       = "a84766c0-5843-4e5d-b879-0b6a23fc125d"
location        = "Central India"
RGname          = "Loop-Count"
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
    name = "TF-Subnet-1"
  },
  {
    ip   = "192.168.1.0/24"
    name = "subnet-1"
  },
  {
    ip   = "172.16.1.0/24"
    name = "subnet--1"
  },
  {
    ip   = "10.0.2.0/24"
    name = "TF-Subnet-2"
  },
  {
    ip   = "192.168.2.0/24"
    name = "subnet-2"
  },
  {
    ip   = "172.16.2.0/24"
    name = "subnet--2"
  },
  {
    ip   = "10.0.3.0/24"
    name = "TF-Subnet-3"
  },
  {
    ip   = "192.168.3.0/24"
    name = "subnet-3"
  },
  {
    ip   = "172.16.3.0/24"
    name = "subnet--3"
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
