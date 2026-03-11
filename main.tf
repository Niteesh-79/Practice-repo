# 1. define the provider (aws)
provider "aws" {
 region ="us-east-1" #we can change this to u preferred region
}

#2. create a vpc
resource "aws_vpc" "main_vpc"{
 cidr_block ="10.0.0.0/16"
 tags = {
  Name ="Project-vpc"
  }
}

#3.create an NGway (to talk server to internet)
resource "aws_internet_gateway" "gw"{
 vpc_id = aws_vpc.main_vpc.id
}

#4.create public subnet
resource "aws_subnet" "public_subnet"{
 vpc_id =aws_vpc.main_vpc.id
 cidr_block ="10.0.1.0/24"
 map_public_ip_on_launch = true
 tags = {
  Name="Public_subnet"
 }

# 5. Create a Security Group (The Firewall)
resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  vpc_id      = aws_vpc.main_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allows SSH from anywhere (be careful!)
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# 6. Launch the EC2 Instance
resource "aws_instance" "web_server" {
  ami           = "ami-0b6c6ebed2801a5cb" # Amazon Linux 2023 AMI (Free Tier)
  instance_type = "t3.micro"             # Keep it Free Tier!
  subnet_id     = aws_subnet.public_subnet.id
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]

  tags = {
    Name = "My-First-IaC-Server"
  }
}
