
locals {

  # determine the admin password
  admin_password = var.vmss_admin_password == "" ? random_password.admin_password[0].result : var.vmss_admin_password
}
