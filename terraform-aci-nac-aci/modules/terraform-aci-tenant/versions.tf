
terraform {
  required_version = ">= 1.0.0"

  required_providers {
    aci = {
      source  = "registry.ssaa.ir:4443/ciscodevnet/aci"
      version = ">= 2.0.0"
    }
  }
}
