resource "aws_instance" "webservers" {
  ami = "ami-0f7cd40eac2214b37"
  instance_type = "t2.micro"
  count = 2
  tags = {
    Name = "webserver"
  }
}