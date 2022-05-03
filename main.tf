provider "aws" {
  region = "ap-south-1"
  profile = "mayank"
}

variable "key" {
  type = string
  default = "ec2"
}

resource "aws_instance" "centos" {
  ami = "ami-079b5e5b3971bd10d"
  instance_type = "t2.micro"
  key_name = var.key
  security_groups = ["launch-wizard-2"]
  tags = {
    Name = "mycentos"
  }
}


output "aws_instance" {
  value = aws_instance.centos
}


resource "aws_ebs_volume" "ebs" {
  availability_zone = aws_instance.centos.availability_zone
  size = 1
  tags = {
    Name = "cenots"
  }
}

resource "aws_volume_attachment" "attach" {
  device_name = "/dev/sdf"
  volume_id = aws_ebs_volume.ebs.id
  instance_id = aws_instance.centos.id
}



