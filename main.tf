provider "aws" {
  region = "us-west-2"
}

# Data sources
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# Local resources
resource "aws_vpc" "demo" {
  cidr_block           = "${var.cidr_block}"
  enable_dns_hostnames = true

  tags {
    Name = "${var.configuration_name}"
  }
}

resource "aws_subnet" "public" {
  vpc_id                  = "${aws_vpc.demo.id}"
  cidr_block              = "${var.cidr_block}"
  map_public_ip_on_launch = true

  tags {
    Name = "${var.configuration_name}"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = "${aws_vpc.demo.id}"

  tags {
    Name = "${var.configuration_name}"
  }
}

resource "aws_route_table" "public" {
  vpc_id = "${aws_vpc.demo.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.igw.id}"
  }

  tags {
    Name = "${var.configuration_name}"
  }
}

resource "aws_route_table_association" "public" {
  subnet_id      = "${aws_subnet.public.id}"
  route_table_id = "${aws_route_table.public.id}"
}

resource "aws_instance" "demo1" {
  ami           = "${data.aws_ami.ubuntu.id}"
  instance_type = "t2.nano"
  subnet_id     = "${aws_subnet.public.id}"

  tags {
    Name = "${var.configuration_name}"
  }
}

resource "aws_instance" "demo2" {
  ami           = "${data.aws_ami.ubuntu.id}"
  instance_type = "m4.large"
  subnet_id     = "${aws_subnet.public.id}"

  tags {
    Name = "${var.configuration_name}"
  }
}
