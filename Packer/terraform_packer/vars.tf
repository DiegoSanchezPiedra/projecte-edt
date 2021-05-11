variable "cidr" {
  type = string
  default = "10.0.0.0/16"
}

variable "pub1_cidr" {
  type = string
  default = "10.0.0.0/24"
}

variable "pub2_cidr" {
  type = string
  default = "10.0.1.0/24"
}

variable "pri1_cidr" {
  type = string
  default = "10.0.10.0/24"
}

variable "pri2_cidr" {
  type = string
  default = "10.0.11.0/24"
}

variable "instance_type" {
  type = string
  default = "t2.micro"
}

variable "region" {
  type = string
  default = "eu-west-3"
}

variable "aws_id" {
  type = string
  default = "723002569774"
}

variable "aws_amis" {
  type = map
  default = {
    "us-east-1" = "ami-09e67e426f25ce0d7" #Virginia
    "us-east-2" = "ami-00399ec92321828f5" #Ohio
    "us-west-1" = "ami-0d382e80be7ffdae5" #California
    "us-west-2" = "ami-03d5c68bab01f3496" #Oregon
    "ap-northeast-3" = "ami-0001d1dd884af8872" #Osaka
    "ap-northeast-2" = "ami-04876f29fd3a5e8ba" #Seoul
    "ap-southeast-1" = "ami-0d058fe428540cd89" #Singapore
    "ap-southeast-2" = "ami-0567f647e75c7bc05" #Sydney
    "ap-northeast-1" = "ami-0df99b3a8349462c6" #Tokyo
    "ca-central-1" = "ami-0801628222e2e96d6" #Central
    "eu-central-1" = "ami-05f7491af5eef733a" #Frakfurt
    "eu-west-1" = "ami-0a8e758f5e873d1c1" #Ireland
    "eu-west-2" = "ami-0194c3e07668a7e36" #London
    "eu-west-3" = "ami-0f7cd40eac2214b37" #Paris
    "eu-north-1" = "ami-0ff338189efb7ed37" #Stockholm
    "sa-east-1" = "ami-054a31f1b3bf90920" #São Paulo
  }
}

variable "project" {
  type = string
  default = "web"
}

variable "environment" {
  type = string
  default = "edt"
}

variable "rds_username" {
  type = string
  default = "root"
}

variable "rds_passwd" {
  type = string
  default = "!Jupiter"
}