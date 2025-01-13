# Generate password for the admin account of the Vm
# This will be used if a password has not been specified
# Generates Random Password for VMSS Admin
resource "random_password" "admin_password" {
  count            = var.vmss_admin_password == "" ? 1 : 0
  length           = 16
  min_upper        = 2
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}
