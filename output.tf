output "vmss_id" {
  value = azurerm_linux_virtual_machine_scale_set.vmss.id
}

output "vmss_admin_password" {
  sensitive = true
  value     = random_password.admin_password[0].result
}

output "setup_script" {
  value = data.template_file.setup_build_agent.rendered
}
