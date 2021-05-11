resource "aws_vpc" "vpc" {
  cidr_block = "${var.cidr}"
  enable_dns_hostnames = true
  enable_dns_support = true
  tags = {
    Name = "edt"
  }
}

resource "aws_subnet" "publica" {
  cidr_block = "${var.pub1_cidr}"
  vpc_id = "${aws_vpc.vpc.id}"
  map_public_ip_on_launch = true
  availability_zone = "${data.aws_availability_zones.az.names[0]}"
  tags = {
  Name = "publica"
  }
}

resource "aws_subnet" "privada1" {
  cidr_block = "${var.pri1_cidr}"
  vpc_id = "${aws_vpc.vpc.id}"
  map_public_ip_on_launch = true
  availability_zone = "${data.aws_availability_zones.az.names[0]}"
  tags = {
    Name = "privada1"
  }
}

resource "aws_subnet" "privada2" {
  cidr_block = "${var.pri2_cidr}"
  vpc_id = "${aws_vpc.vpc.id}"
  map_public_ip_on_launch = true
  availability_zone = "${data.aws_availability_zones.az.names[1]}"
  tags = {
    Name = "privada2"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = "${aws_vpc.vpc.id}"
}

resource "aws_route" "default_route" {
  route_table_id = "${aws_vpc.vpc.default_route_table_id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = "${aws_internet_gateway.igw.id}"
}