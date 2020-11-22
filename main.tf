provider "aws" {
  profile = "default"
  region  = "${var.myregion}"
}
resource "aws_instance" "instance_ws" {
   ami = "ami-03657b56516ab7912"
  # subnet_id = aws_subnet.wssubnet.id
   count = "${var.wscount}"
   instance_type = "t2.micro"
      tags          = {
    Name        = "web Server-${count.index}"
    Environment = "production"

  }
}
resource "aws_instance" "instance_db" {
   ami = "ami-03657b56516ab7912"
   #subnet_id = aws_subnet.dbsubnet.id
   instance_type = "t2.micro"
   security_groups = ["${aws_security_group.DBSG.id}"]
    tags = {
      Name = " Dataserver "
   }
}     
resource "aws_vpc" "prod_vpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "prod_vpc"
  }
}
resource "aws_subnet" "wssubnet" {
  vpc_id     = aws_vpc.prod_vpc.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "ws_subnet"
  }
}
resource "aws_subnet" "wssubnet2" {
  vpc_id     = aws_vpc.prod_vpc.id
  cidr_block = "10.0.3.0/24"

  tags = {
    Name = "ws_subnet2"
  }
}
resource "aws_subnet" "dbsubnet" {
  vpc_id     = aws_vpc.prod_vpc.id
  cidr_block = "10.0.2.0/24"

  tags = {
    Name = "db_subnet"
  }
}
resource "aws_security_group" "DBSG" {
  name        = "DBSG"
  description = "DBSG inbound traffic"
  vpc_id      = aws_vpc.prod_vpc.id

  ingress {
    description = "inbound"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }

  egress {
    description = "outbound"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }
}