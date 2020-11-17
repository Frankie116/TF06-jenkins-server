data "aws_ami" "myami" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}


resource "aws_vpc" "myvpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
}


resource "aws_internet_gateway" "mygw" {
  vpc_id = aws_vpc.myvpc.id
}


resource "aws_subnet" "mysubnet" {
  vpc_id                  = aws_vpc.myvpc.id
  cidr_block              = "10.0.0.0/24"
  map_public_ip_on_launch = true

  depends_on = [aws_internet_gateway.mygw]
}


resource "aws_network_interface" "mynetworkinterface" {
  subnet_id   = aws_subnet.mysubnet.id
  private_ips = ["10.0.0.12"]

  tags = {
    Name = "primary_network_interface"
  }
}


resource "aws_instance" "myec2" {
  ami           = data.aws_ami.myami.id
  instance_type = var.instance_type

  network_interface {
    network_interface_id = aws_network_interface.mynetworkinterface.id
    device_index         = 0
  }

  tags          = {
    Name        = var.my-tag-name
  }
}


resource "aws_eip" "myeip" {
  vpc = true

  instance                  = aws_instance.myec2.id
  associate_with_private_ip = "10.0.0.12"
  depends_on                = [aws_internet_gateway.mygw]
}