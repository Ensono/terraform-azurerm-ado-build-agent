
# Terraform ADO Build Agent

This module creates a private Azure DevOps Build agent running on a virtual machine scaleset (VMSS) which can be used when building and deploying a data project.

To use the module reference the GitHub repo in the Terraform file, for example:

```
module "kv_default" {
    source = "github.com/ensono/terraform-azurerm-ado-build-agent"
    ...
}
```

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |
| <a name="provider_template"></a> [template](#provider\_template) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_linux_virtual_machine_scale_set.vmss](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine_scale_set) | resource |
| [azurerm_virtual_machine_scale_set_extension.setup](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_machine_scale_set_extension) | resource |
| [random_password.admin_password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [azurerm_subnet.subnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |
| [template_file.setup_build_agent](https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ado_agent_pool"></a> [ado\_agent\_pool](#input\_ado\_agent\_pool) | Name of the Azure DevOps Agent Pool to which this agent belongs | `string` | n/a | yes |
| <a name="input_ado_agent_version"></a> [ado\_agent\_version](#input\_ado\_agent\_version) | Version of the Azure DevOps Agent | `string` | `"4.248.0"` | no |
| <a name="input_ado_org_url"></a> [ado\_org\_url](#input\_ado\_org\_url) | URL of the Azure DevOps Organization | `string` | n/a | yes |
| <a name="input_ado_pat"></a> [ado\_pat](#input\_ado\_pat) | Personal Access Token for the Azure DevOps Organization | `string` | n/a | yes |
| <a name="input_ado_project_id"></a> [ado\_project\_id](#input\_ado\_project\_id) | ID of the Azure DevOps Project | `string` | n/a | yes |
| <a name="input_debug_enabled"></a> [debug\_enabled](#input\_debug\_enabled) | If debug enabled then SSH will be enabled inbound on the NSG | `bool` | `false` | no |
| <a name="input_ip_configuration_name"></a> [ip\_configuration\_name](#input\_ip\_configuration\_name) | Name of the IP Config on the VMs NIC. | `string` | `"primary"` | no |
| <a name="input_location_name_map"></a> [location\_name\_map](#input\_location\_name\_map) | Each region must have corresponding a shortend name for resource naming purposes | `map(string)` | <pre>{<br/>  "eastasia": "ase",<br/>  "eastus": "use",<br/>  "eastus2": "use2",<br/>  "northeurope": "eun",<br/>  "southeastasia": "asse",<br/>  "uksouth": "uks",<br/>  "ukwest": "ukw",<br/>  "westeurope": "euw",<br/>  "westus": "usw"<br/>}</pre> | no |
| <a name="input_network_interface_name"></a> [network\_interface\_name](#input\_network\_interface\_name) | Name of the VMs NIC. | `string` | `"primary"` | no |
| <a name="input_overprovision"></a> [overprovision](#input\_overprovision) | Bool to set overprovisioning. | `bool` | `false` | no |
| <a name="input_subnet_name"></a> [subnet\_name](#input\_subnet\_name) | Name of the  Subnet which the VMSS will be provisioned. | `string` | `""` | no |
| <a name="input_upgrade_mode"></a> [upgrade\_mode](#input\_upgrade\_mode) | Upgrade mode for VMSS instances | `string` | `"Automatic"` | no |
| <a name="input_vmss_admin_password"></a> [vmss\_admin\_password](#input\_vmss\_admin\_password) | Password for Admin SSH Access to VMs. | `string` | `""` | no |
| <a name="input_vmss_admin_ssh_key"></a> [vmss\_admin\_ssh\_key](#input\_vmss\_admin\_ssh\_key) | SSH Public Key for Admin SSH Access to VMs. | `string` | `""` | no |
| <a name="input_vmss_admin_username"></a> [vmss\_admin\_username](#input\_vmss\_admin\_username) | Username for Admin SSH Access to VMs. | `string` | `""` | no |
| <a name="input_vmss_disable_password_auth"></a> [vmss\_disable\_password\_auth](#input\_vmss\_disable\_password\_auth) | Boolean to enable or disable password authentication to VMs. | `bool` | `false` | no |
| <a name="input_vmss_disk_caching"></a> [vmss\_disk\_caching](#input\_vmss\_disk\_caching) | Disk Caching options. | `string` | `"ReadWrite"` | no |
| <a name="input_vmss_image_offer"></a> [vmss\_image\_offer](#input\_vmss\_image\_offer) | Image offer. Eg UbuntuServer | `string` | `"0001-com-ubuntu-server-jammy"` | no |
| <a name="input_vmss_image_publisher"></a> [vmss\_image\_publisher](#input\_vmss\_image\_publisher) | Image Publisher. | `string` | `"Canonical"` | no |
| <a name="input_vmss_image_sku"></a> [vmss\_image\_sku](#input\_vmss\_image\_sku) | Image SKU. | `string` | `"22_04-lts-gen2"` | no |
| <a name="input_vmss_image_version"></a> [vmss\_image\_version](#input\_vmss\_image\_version) | Version of VM Image SKU required. | `string` | `"latest"` | no |
| <a name="input_vmss_instances"></a> [vmss\_instances](#input\_vmss\_instances) | Default number of instances within the scaleset. | `number` | `1` | no |
| <a name="input_vmss_name"></a> [vmss\_name](#input\_vmss\_name) | Name of the VMSS | `string` | `""` | no |
| <a name="input_vmss_network_profile_lb_backend_pool"></a> [vmss\_network\_profile\_lb\_backend\_pool](#input\_vmss\_network\_profile\_lb\_backend\_pool) | ID of the Backend pool to attached the VMSS to | `string` | `""` | no |
| <a name="input_vmss_network_profile_lb_nat_rule"></a> [vmss\_network\_profile\_lb\_nat\_rule](#input\_vmss\_network\_profile\_lb\_nat\_rule) | ID of the NAT rule to use in the VMSS | `string` | `""` | no |
| <a name="input_vmss_resource_group_location"></a> [vmss\_resource\_group\_location](#input\_vmss\_resource\_group\_location) | Location of Resource group | `string` | `"uksouth"` | no |
| <a name="input_vmss_resource_group_name"></a> [vmss\_resource\_group\_name](#input\_vmss\_resource\_group\_name) | name of resource group | `string` | `""` | no |
| <a name="input_vmss_sku"></a> [vmss\_sku](#input\_vmss\_sku) | VM Size | `string` | `"Standard_B4ms"` | no |
| <a name="input_vmss_storage_account_type"></a> [vmss\_storage\_account\_type](#input\_vmss\_storage\_account\_type) | Storeage type used for VMSS Disk. | `string` | `"StandardSSD_LRS"` | no |
| <a name="input_vnet_name"></a> [vnet\_name](#input\_vnet\_name) | Name of the VNET which the VMSS will be provisioned. | `string` | `""` | no |
| <a name="input_vnet_resource_group"></a> [vnet\_resource\_group](#input\_vnet\_resource\_group) | Name of the Resource Group in which the VNET is provisioned. | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_setup_script"></a> [setup\_script](#output\_setup\_script) | n/a |
| <a name="output_vmss_admin_password"></a> [vmss\_admin\_password](#output\_vmss\_admin\_password) | n/a |
| <a name="output_vmss_id"></a> [vmss\_id](#output\_vmss\_id) | n/a |
<!-- END_TF_DOCS -->

## Troubleshooting

The following components are installed using the CustomScript extension:

* Azure DevOps Pipeline Agent
* PowerShell
* Docker

If this happens to fail on any of the nodes, the script itself, `stdout` and `stderr` output can be found in `/var/lib/waagent/custom-script/download/1`.


Create Public IP Address
Create Load Balancer
Add NAT rule for SSH
Update NSG to allow SSH
Ensure public key is on VMSS resource