provider "aws" {
  profile = "default"
  region  = "us-east-2"
}

resource "aws_instance" "FirstInstance" {
   ami = ""
   instance_type = "t2.micro"
}
