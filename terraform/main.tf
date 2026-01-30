provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "servers" {
  count         = 3
  ami           = "ami-019715e0d74f695be"   
  instance_type = "t2.micro"
  key_name      = "25-nov-25-thinkpadoff"         

  tags = {
    Name = "Server-${count.index + 1}"
  }
}
