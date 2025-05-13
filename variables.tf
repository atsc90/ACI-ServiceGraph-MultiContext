variable "url" {}
variable "username" {}
variable "password" {}

variable "aci_vpc_domain_policy_name" {}
variable "aci_vpc_explicit_protection_group_name" {}
variable "aci_vpc_explicit_protection_group_switch1" {}
variable "aci_vpc_explicit_protection_group_switch2" {}

variable "aci_vlan_pool_name" {}
variable "aci_vlan_pool_alloc_mode" {}
variable "aci_ranges_from_vlan" {}
variable "aci_ranges_to_vlan" {}
variable "aci_ranges_alloc_mode" {}

variable "aci_physical_domain_name" {}

variable "aci_l3_domain_name" {}

variable "aci_attachable_access_entity_profile_name" {}

variable "aci_leaf_profile_name" {}
variable "aci_leaf_profile_selector_name" {}
variable "aci_leaf_profile_selector_name_switch_association_type" {}
variable "aci_leaf_profile_selector_node_block01_name" {}
variable "aci_leaf_profile_selector_node_block01_from" {}
variable "aci_leaf_profile_selector_node_block01_to" {}
variable "aci_leaf_profile_selector_node_block02_name" {}
variable "aci_leaf_profile_selector_node_block02_from" {}
variable "aci_leaf_profile_selector_node_block02_to" {}

variable "aci_leaf_interface_profile_name" {}
variable "aci_leaf_interface_selector_name" {}
variable "policy_group_type" {}
variable "policy_group_name" {}
variable "port_blocks_name" {}
variable "port_blocks_from_module" {}
variable "port_blocks_to_module" {}
variable "port_blocks_from_port" {}
variable "port_blocks_to_port" {}

variable "aci_leaf_interface_profile_name_2" {}
variable "aci_leaf_interface_selector_name_2" {}
variable "policy_group_type_2" {}
variable "policy_group_name_2" {}
variable "port_blocks_name_2" {}
variable "port_blocks_from_module_2" {}
variable "port_blocks_to_module_2" {}
variable "port_blocks_from_port_2" {}
variable "port_blocks_to_port_2" {}