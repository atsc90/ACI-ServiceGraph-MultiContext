provider "aci" {
    url      = var.url
    username = var.username
    password = var.password
}

module "vlan_pool" {
  source  = "./terraform-aci-nac-aci/"
  #version = ">= 0.7.0"

  yaml_files = ["my-tenant.yaml"]

  manage_access_policies    = false
  manage_fabric_policies    = false
  manage_pod_policies       = false
  manage_node_policies      = false
  manage_interface_policies = false
  manage_tenants            = true
}