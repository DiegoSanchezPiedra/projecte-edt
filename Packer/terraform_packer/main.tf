terraform {
  required_version = ">=0.15.1"
}

provider "aws" {
  region = "${var.region}"
  allowed_account_ids = [ "903584233714" ]
  profile = "terraform"
}

data "aws_availability_zones" "az" {}