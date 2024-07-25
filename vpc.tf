resource "aws_vpc" "demo-vpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

}
resource "aws_subnet" "demo-subnet1" {
   vpc_id     = aws_vpc.demo-vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1a"
  
}
resource "aws_subnet" "demo-subnet2" {
   vpc_id     = aws_vpc.demo-vpc.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "us-east-1b"
  
}

resource "aws_db_subnet_group" "demo-subnet-group" {
  name       = "main"
  subnet_ids = [aws_subnet.demo-subnet1.id, aws_subnet.demo-subnet2.id]

  tags = {
    Name = "demo-subnet-group"
  }
}

resource "aws_security_group" "demo-ec2-sg" {
  vpc_id = aws_vpc.demo-vpc.id

  ingress {
    from_port   = 1433
    to_port     = 1433
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.demo-vpc.cidr_block]
  }

   egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

resource "aws_security_group" "demo-rds-sg" {
  vpc_id = aws_vpc.demo-vpc.id

  ingress {
    from_port   = 1433
    to_port     = 1433
    protocol    = "tcp"
    security_groups = [aws_security_group.demo-ec2-sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
