# ACI Login
url      = "your apic address"
username = "your user"
password = "your password"

# VPC Domain
aci_vpc_domain_policy_name                = "my-vpc-domain"
aci_vpc_explicit_protection_group_name    = "my-vpc-explicit-protection-group"
aci_vpc_explicit_protection_group_switch1 = "1213"
aci_vpc_explicit_protection_group_switch2 = "1223"

# Vlan Pool
aci_vlan_pool_name       = "my-vlan-pool"
aci_vlan_pool_alloc_mode = "static"
aci_ranges_from_vlan     = "vlan-1800"
aci_ranges_to_vlan       = "vlan-1819"
aci_ranges_alloc_mode    = "static"

# Physical Domain
aci_physical_domain_name = "my-physical-domain"

# L3 Domain
aci_l3_domain_name = "my-l3-domain"

# Attachable Access Entity Profile
aci_attachable_access_entity_profile_name = "my-aaep"

# Leaf Profile
aci_leaf_profile_name = "my-aci-leaf-profile"
aci_leaf_profile_selector_name = "my-aci-leaf-selector"
aci_leaf_profile_selector_name_switch_association_type = "range"
aci_leaf_profile_selector_node_block01_name = "1213"
aci_leaf_profile_selector_node_block01_from = "1213"
aci_leaf_profile_selector_node_block01_to = "1213"
aci_leaf_profile_selector_node_block02_name = "1223"
aci_leaf_profile_selector_node_block02_from = "1223"
aci_leaf_profile_selector_node_block02_to = "1223"

# Interface Profile 1
# Leaf Interface Profile
aci_leaf_interface_profile_name = "my-aci-leaf-interface-profile"
# Leaf Interface Selector
aci_leaf_interface_selector_name = "my-aci-access-interface-selector"
# Interface Policy Group Type
policy_group_type = "vpc"
# Interface Policy Name
policy_group_name = "VPC_FTD2130_1"
# Interface Port Block
port_blocks_name        = "my-aci-block"
port_blocks_from_module = "1"
port_blocks_to_module   = "1"
port_blocks_from_port   = "47"
port_blocks_to_port     = "47"

# Interface Profile 2
# Leaf Interface Profile
aci_leaf_interface_profile_name_2 = "my-aci-leaf-interface-profile-2"
# Leaf Interface Selector
aci_leaf_interface_selector_name_2 = "my-aci-access-interface-selector-2"
# Interface Policy Group Type
policy_group_type_2 = "vpc"
# Interface Policy Name
policy_group_name_2 = "VPC_FTD2130_2"
# Interface Port Block
port_blocks_name_2        = "my-aci-block-2"
port_blocks_from_module_2 = "1"
port_blocks_to_module_2   = "1"
port_blocks_from_port_2   = "48"
port_blocks_to_port_2     = "48"