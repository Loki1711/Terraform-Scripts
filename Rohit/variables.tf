
variable "RGname" {
  description = "This is the name for the RG"
}

variable "location" {
  description = "This is the location for the RG"
}

variable "tags" {
  type = map(any)
}

variable "vnet" {}

variable "address_space" {}

variable "username" {}

variable "passwd" {}