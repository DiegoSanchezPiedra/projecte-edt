terraform {
  required_version = ">=0.15.1"
}

provider "aws" {
  region = "eu-west-3"
  allowed_account_ids = [ "903584233714" ]
  profile = "terraform"
}

resource "aws_vpc" "vpc" {
  cidr_block = "10.0.0.0/24"
  #las instancias tienen un DNS privado
  enable_dns_hostnames = true
  enable_dns_support = true
  tags = {
    "Name" = "edt"
  }
}