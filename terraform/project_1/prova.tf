provider "aws" {
  region = "eu-west-3"
}

resource "aws_instance" "my_first_server" {
  ami           = "ami-0d6aecf0f0425f42a" #free
  instance_type = "t2.micro" #free
}