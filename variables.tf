############################################
# NAMING
############################################
variable "vnet_name" {
  type        = string
  default     = ""
  description = "Name of the VNET which the VMSS will be provisioned."
}

variable "vnet_resource_group" {
  type        = string
  default     = ""
  description = "Name of the Resource Group in which the VNET is provisioned."
}

variable "subnet_name" {
  type        = string
  default     = ""
  description = "Name of the  Subnet which the VMSS will be provisioned."
}

variable "vmss_name" {
  type        = string
  default     = ""
  description = "Name of the VMSS"
}

variable "network_interface_name" {
  type        = string
  default     = "primary"
  description = "Name of the VMs NIC."
}

variable "ip_configuration_name" {
  type        = string
  default     = "primary"
  description = "Name of the IP Config on the VMs NIC."
}

############################################
# RESOURCE INFORMATION
############################################

variable "vmss_resource_group_location" {
  type        = string
  default     = "uksouth"
  description = "Location of Resource group"
}

variable "vmss_resource_group_name" {
  type        = string
  description = "name of resource group"
  default     = ""
}

# Each region must have corresponding a shortend name for resource naming purposes 
variable "location_name_map" {
  type = map(string)

  default = {
    northeurope   = "eun"
    westeurope    = "euw"
    uksouth       = "uks"
    ukwest        = "ukw"
    eastus        = "use"
    eastus2       = "use2"
    westus        = "usw"
    eastasia      = "ase"
    southeastasia = "asse"
  }
}

variable "vmss_sku" {
  type        = string
  default     = "Standard_B4ms"
  description = "VM Size"
}

variable "vmss_instances" {
  type        = number
  default     = 1
  description = "Default number of instances within the scaleset."
}

variable "vmss_admin_username" {
  type        = string
  default     = ""
  description = "Username for Admin SSH Access to VMs."
}

variable "vmss_admin_password" {
  type        = string
  default     = ""
  description = "Password for Admin SSH Access to VMs."
}

variable "vmss_disable_password_auth" {
  type        = bool
  default     = false
  description = "Boolean to enable or disable password authentication to VMs."
}

variable "vmss_image_publisher" {
  type        = string
  default     = "Canonical"
  description = "Image Publisher."
}

variable "vmss_image_offer" {
  type        = string
  default     = "0001-com-ubuntu-server-jammy"
  description = "Image offer. Eg UbuntuServer"
}

variable "vmss_image_sku" {
  type        = string
  default     = "22_04-lts-gen2"
  description = "Image SKU."
}

variable "vmss_image_version" {
  type        = string
  default     = "latest"
  description = "Version of VM Image SKU required."
}

variable "vmss_storage_account_type" {
  type        = string
  default     = "StandardSSD_LRS"
  description = "Storeage type used for VMSS Disk."
}

variable "vmss_disk_caching" {
  type        = string
  default     = "ReadWrite"
  description = "Disk Caching options."
}

variable "vmss_network_profile_lb_backend_pool" {
  type        = string
  default     = ""
  description = "ID of the Backend pool to attached the VMSS to"
}

variable "vmss_network_profile_lb_nat_rule" {
  type        = string
  default     = ""
  description = "ID of the NAT rule to use in the VMSS"
}

variable "overprovision" {
  type        = bool
  default     = false
  description = "Bool to set overprovisioning."
}

####################################################
# Azure DevOps Agent Configuration
####################################################

variable "ado_agent_pool" {
  type        = string
  description = "Name of the Azure DevOps Agent Pool to which this agent belongs"
}

variable "ado_org_url" {
  type        = string
  description = "URL of the Azure DevOps Organization"
}

variable "ado_pat" {
  type        = string
  description = "Personal Access Token for the Azure DevOps Organization"
}

variable "ado_project_id" {
  type        = string
  description = "ID of the Azure DevOps Project"
}

variable "ado_agent_version" {
  type        = string
  default     = "4.248.0"
  description = "Version of the Azure DevOps Agent"
}

variable "debug_enabled" {
  type        = bool
  default     = false
  description = "If debug enabled then SSH will be enabled inbound on the NSG"
}

variable "vmss_admin_ssh_key" {
  type        = string
  default     = ""
  description = "SSH Public Key for Admin SSH Access to VMs."
}

variable "upgrade_mode" {
  type        = string
  default     = "Automatic"
  description = "Upgrade mode for VMSS instances"
}
