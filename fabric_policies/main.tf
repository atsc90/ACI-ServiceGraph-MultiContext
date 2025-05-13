# This local is used for "aci_leaf_access_bundle_policy_group" (end of page)
locals {
  lags = {

    "VPC_FTD2130_1" = {
      leaf_1        = "1213"
      leaf_2        = "1223"
      from_port     = 1/47
      to_port       = 1/47
      aep           = "my-aaep"
    }

    "VPC_FTD2130_2" = {
      leaf_1        = "1213"
      leaf_2        = "1223"
      from_port     = 1/48
      to_port       = 1/48
      aep           = "my-aaep"
    }

  }
}

# Fabric >> Access Policies >> Policies >> Switch >> VPC Domain
resource "aci_vpc_domain_policy" "my-vpc-domain" {
  name        = var.aci_vpc_domain_policy_name
  #name_alias = "my-vpc-domain"
}

# Fabric >> Access Policies >> Policies >> Switch >> Virtual Port Channel Default (Not A Directory)
resource "aci_vpc_explicit_protection_group" "my-vpc-explicit-protection-group" {
  name                             = var.aci_vpc_explicit_protection_group_name
  switch1                          = var.aci_vpc_explicit_protection_group_switch1
  switch2                          = var.aci_vpc_explicit_protection_group_switch2
  #You need "name" for vpc domain policy
  vpc_domain_policy                = aci_vpc_domain_policy.my-vpc-domain.name
  vpc_explicit_protection_group_id = "1"
}

# Fabric >> Access Policies >> Pools >> VLAN
resource "aci_vlan_pool" "my-vlan-pool" {
  name       = var.aci_vlan_pool_name
  alloc_mode = var.aci_vlan_pool_alloc_mode
}

# Fabric >> Access Policies >> Pools >> VLAN >> (Inside the vlan pool file)
resource "aci_ranges" "my-vlan-1800-1819-range" {
  vlan_pool_dn = aci_vlan_pool.my-vlan-pool.id
  from         = var.aci_ranges_from_vlan
  to           = var.aci_ranges_to_vlan
  alloc_mode   = var.aci_ranges_alloc_mode
}

# Fabric >> Access Policies >> Physical and External Domains >> Physical Domains
resource "aci_physical_domain" "my-physical-domain" {
  name                      = var.aci_physical_domain_name
  relation_infra_rs_vlan_ns = aci_vlan_pool.my-vlan-pool.id
}

# Fabric >> Access Policies >> Physical and External Domains >> L3 Domains
resource "aci_l3_domain_profile" "my-l3-domain" {
  name                      = var.aci_l3_domain_name
  relation_infra_rs_vlan_ns = aci_vlan_pool.my-vlan-pool.id
}

# Fabric >> Access Policies >> Policies >> Global >> Attachable Access Entity Profiles
resource "aci_attachable_access_entity_profile" "my-aaep" {
  name = var.aci_attachable_access_entity_profile_name
  relation_infra_rs_dom_p = [
    aci_physical_domain.my-physical-domain.id ,
    aci_l3_domain_profile.my-l3-domain.id
  ]
}

/*
# Access generic resource for AEP, not for Network!!!!
resource "aci_access_generic" "epg_to_aep" {
  attachable_access_entity_profile_dn = aci_attachable_access_entity_profile.my-aaep.id
  name                                = "default"
}
*/

# Interface Policies
# Fabric >> Policies >> Interface >> Port Channel
resource "aci_lacp_policy" "lacp_policy" {
  ctrl = [
    "fast-sel-hot-stdby",
    "graceful-conv",
    "susp-individual",
  ]
  max_links = "16"
  min_links = "1"
  mode      = "active"
  name      = "lacp_policy_active"
}

# Fabric >> Policies >> Interface >> CDP Interface
resource "aci_cdp_interface_policy" "cdp_policy" {
  name     = "cdp_policy"
  admin_st = "enabled"
}

# Fabric >> Policies >> Interface >> MCP Interface
resource "aci_miscabling_protocol_interface_policy" "mcp_policy" {
  name     = "mcp_policy"
  admin_st = "enabled"
}

# Fabric >> Policies >> Interface >> LLDP Interface
resource "aci_lldp_interface_policy" "lldp_policy" {
  name        = "lldp_policy"
  admin_rx_st = "enabled"
  admin_tx_st = "enabled"
}

# Fabric >> Policies >> Interface >> Link Level
resource "aci_fabric_if_pol" "if_policy" {
  name          = "link_level_auto"
  auto_neg      = "on"
  fec_mode      = "inherit"
  link_debounce = "100"
  speed         = "inherit"
}

# Fabric >> Interfaces >> Leaf Interfaces >> Policy Groups >> VPC Interface
resource "aci_leaf_access_bundle_policy_group" "my-aci-leaf-access-bundle-policy-group" {
  for_each                      = local.lags
  lag_t                         = "node"
  name                          = each.key
  relation_infra_rs_att_ent_p   = "uni/infra/attentp-${each.value.aep}"
  relation_infra_rs_h_if_pol    = aci_fabric_if_pol.if_policy.id
  relation_infra_rs_cdp_if_pol  = aci_cdp_interface_policy.cdp_policy.id
  relation_infra_rs_mcp_if_pol  = aci_miscabling_protocol_interface_policy.mcp_policy.id
  relation_infra_rs_lldp_if_pol = aci_lldp_interface_policy.lldp_policy.id
  relation_infra_rs_lacp_pol    = aci_lacp_policy.lacp_policy.id
  depends_on                    = [aci_attachable_access_entity_profile.my-aaep]
}

# Fabric >> Switches >> Leaf Switches >> Profiles
resource "aci_leaf_profile" "my-aci-leaf-profile" {
  name = var.aci_leaf_profile_name
  leaf_selector {
    name                    = var.aci_leaf_profile_selector_name
    switch_association_type = var.aci_leaf_profile_selector_name_switch_association_type
    node_block {
      name  = var.aci_leaf_profile_selector_node_block01_name
      from_ = var.aci_leaf_profile_selector_node_block01_from
      to_   = var.aci_leaf_profile_selector_node_block01_to
    }
    node_block {
      name  = var.aci_leaf_profile_selector_node_block02_name
      from_ = var.aci_leaf_profile_selector_node_block02_from
      to_   = var.aci_leaf_profile_selector_node_block02_to
    }
  }
  # Relation to Leaf Interface Profile
  # You can add as much Leaf Interface Profile as that you got
  relation_infra_rs_acc_port_p = [
    aci_leaf_interface_profile.my-aci-leaf-interface-profile.id,
    aci_leaf_interface_profile.my-aci-leaf-interface-profile-2.id
  ]
}

# Interface Profile 1
# Fabric >> Interfaces >> Leaf Interfaces >> Profiles
resource "aci_leaf_interface_profile" "my-aci-leaf-interface-profile" {
  name = var.aci_leaf_interface_profile_name
}

# Terraform ACI Access Leaf Interface Selector Module
module "aci_access_leaf_interface_selector" {
  source = "/ACI-TERRAFROM/terraform-aci-access-leaf-interface-selector"

  # Leaf interface Profile name
  interface_profile = aci_leaf_interface_profile.my-aci-leaf-interface-profile.name
  # Leaf interface selector name
  name              = var.aci_leaf_interface_selector_name
  policy_group_type = var.policy_group_type
  policy_group      = var.policy_group_name
  port_blocks       = [{
      name          = var.port_blocks_name
      from_module   = var.port_blocks_from_module
      to_module     = var.port_blocks_to_module
      from_port     = var.port_blocks_from_port
      to_port       = var.port_blocks_to_port
    }]
}

# Interface Profile 2  
# Fabric >> Interfaces >> Leaf Interfaces >> Profiles
resource "aci_leaf_interface_profile" "my-aci-leaf-interface-profile-2" {
  name = var.aci_leaf_interface_profile_name_2
}

# Terraform ACI Access Leaf Interface Selector Module
module "aci_access_leaf_interface_selector_2" {
  source = "/ACI-TERRAFROM/terraform-aci-access-leaf-interface-selector"

  # Leaf interface Profile name
  interface_profile = aci_leaf_interface_profile.my-aci-leaf-interface-profile-2.name
  # Leaf interface selector name
  name              = var.aci_leaf_interface_selector_name_2
  policy_group_type = var.policy_group_type_2
  policy_group      = var.policy_group_name_2
  port_blocks       = [{
      name          = var.port_blocks_name_2
      from_module   = var.port_blocks_from_module_2
      to_module     = var.port_blocks_to_module_2
      from_port     = var.port_blocks_from_port_2
      to_port       = var.port_blocks_to_port_2
    }]
}