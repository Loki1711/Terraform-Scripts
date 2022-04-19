
output "RG-output" {
  value = azurerm_resource_group.RG.id
}
/*
output "PIP" {
  value = azurerm_public_ip.PIP.*.ip_address
}
output "VM" {
  value = azurerm_virtual_machine.VM.*.name
}*/