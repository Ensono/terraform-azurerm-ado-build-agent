resource "azurerm_linux_virtual_machine_scale_set" "vmss" {
  name                            = var.vmss_name
  location                        = var.vmss_resource_group_location
  resource_group_name             = var.vmss_resource_group_name
  sku                             = var.vmss_sku
  instances                       = var.vmss_instances
  admin_username                  = var.vmss_admin_username
  admin_password                  = local.admin_password
  disable_password_authentication = var.vmss_disable_password_auth
  overprovision                   = var.overprovision

  source_image_reference {
    publisher = var.vmss_image_publisher
    offer     = var.vmss_image_offer
    sku       = var.vmss_image_sku
    version   = var.vmss_image_version
  }

  # Add in the admin ssh key, if a key has been specified and we are in debug mode
  dynamic "admin_ssh_key" {
    for_each = var.debug_enabled == true && var.vmss_admin_ssh_key != "" ? [1] : []
    content {
      username   = "adminuser"
      public_key = var.vmss_admin_ssh_key
    }
  }

  network_interface {
    name    = var.network_interface_name
    primary = true

    ip_configuration {
      name      = var.ip_configuration_name
      primary   = true
      subnet_id = data.azurerm_subnet.subnet.id

      load_balancer_backend_address_pool_ids = var.debug_enabled == true && var.vmss_network_profile_lb_backend_pool != "" ? [var.vmss_network_profile_lb_backend_pool] : []
      load_balancer_inbound_nat_rules_ids    = var.debug_enabled == true && var.vmss_network_profile_lb_nat_rule != "" ? [var.vmss_network_profile_lb_nat_rule] : []
    }
  }

  os_disk {
    storage_account_type = var.vmss_storage_account_type
    caching              = var.vmss_disk_caching
  }

  # Allow the scaleset to auto upgrade
  # This is so that the agents can be set to the latest model automatically
  upgrade_mode = var.upgrade_mode

  lifecycle {
    ignore_changes = [
      tags,
    ]
  }
}
