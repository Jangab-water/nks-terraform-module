terraform {
  required_providers {
    ncloud ={
      source="NaverCloudPlatform/ncloud"
    }
  }
  required_version = ">=0.13"
}

provider ncloud {
  region = var.region
  site = var.site
  support_vpc = true
}

