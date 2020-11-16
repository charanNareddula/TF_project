provider "aws" {
  profile = "default"
  region  = "${var.myregion}"
}

resource "aws_instance" "instance_ws" {
   ami = "ami-03657b56516ab7912"
   subnet_id = aws_subnet.wssubnet.id
   count = "${var.wscount}"
   instance_type = "t2.micro"
      tags          = {
    Name        = "web Server-${count.index}"
    Environment = "production"

  }
}
resource "aws_instance" "instance_db" {
   ami = "ami-03657b56516ab7912"
   subnet_id = aws_subnet.dbsubnet.id
   instance_type = "t2.micro"
    tags = {
      Name = " Dataserver "
   }
}  
resource "aws_vpc" "prod_vpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "vpc1"
  }
}
resource "aws_subnet" "wssubnet" {
  vpc_id     = aws_vpc.prod_vpc.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "ws_subnet"
  }
}
resource "aws_subnet" "dbsubnet" {
  vpc_id     = aws_vpc.prod_vpc.id
  cidr_block = "10.0.2.0/24"

  tags = {
    Name = "db_subnet"
  }
}