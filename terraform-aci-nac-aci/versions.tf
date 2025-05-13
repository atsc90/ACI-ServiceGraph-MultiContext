terraform {
  required_version = ">= 1.3.0"

  required_providers {
    aci = {
      source  = "registry.ssaa.ir:4443/ciscodevnet/aci"
      version = ">= 2.15.0"
    }
    utils = {
      source  = "registry.ssaa.ir:4443/netascode/utils"
      version = ">= 0.2.5"
    }
    local = {
      source  = "registry.ssaa.ir:4443/hashicorp/local"
      version = ">= 2.3.0"
    }
  }
}
