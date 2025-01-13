resource "azurerm_virtual_machine_scale_set_extension" "setup" {
  name                         = "InstallDataComponents"
  virtual_machine_scale_set_id = azurerm_linux_virtual_machine_scale_set.vmss.id
  publisher                    = "Microsoft.Azure.Extensions"
  type                         = "CustomScript"
  type_handler_version         = "2.1"
  settings = jsonencode({
    "script" = base64encode(data.template_file.setup_build_agent.rendered)
  })
}
