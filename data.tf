
# Get details of the subnet the vmss needs to be connected to
data "azurerm_subnet" "subnet" {
  name                 = var.subnet_name
  virtual_network_name = var.vnet_name
  resource_group_name  = var.vnet_resource_group
}

# Path to template that will be used to install all the components
# for the build agent
data "template_file" "setup_build_agent" {
  template = file("${path.module}/scripts/ci_cd_tool_install.sh.tpl")
  vars = {
    ado_agent_pool = var.ado_agent_pool
    ado_org_url    = var.ado_org_url
    ado_pat        = var.ado_pat
    ado_project_id = var.ado_project_id
  }
}

