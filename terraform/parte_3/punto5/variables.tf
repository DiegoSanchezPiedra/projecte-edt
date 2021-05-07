variable "cidr" {
  type = string
  default = "10.0.0.0/24"
}
variable "ami-id" {
  type = string
  default = "ami-0f7cd40eac2214b37"
}

variable "instance-type" {
  type = string
  default = "t2.micro"
}