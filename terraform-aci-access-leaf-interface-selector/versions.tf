/*
terraform {
  required_version = ">= 1.3.0"

  required_providers {
    aci = {
      source  = "CiscoDevNet/aci"
      version = ">= 2.0.0"
    }
  }
}
*/

terraform {
  required_providers {
    aci = {
        source = "registry.ssaa.ir:4443/ciscodevnet/aci"
    }
  }
}