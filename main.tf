resource "aws_vpc" "rds-demo-vpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "rds-demo-vpc"
  }
}

resource "aws_subnet" "rds-demo-subnet1" {
   vpc_id     = aws_vpc.rds-demo-vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name = "rds-demo-subnet1"
  }
  
}
resource "aws_subnet" "rds-demo-subnet2" {
   vpc_id     = aws_vpc.rds-demo-vpc.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "us-east-1b"
  tags = {
    Name = "rds-demo-subnet2"
  }
  
}

resource "aws_db_subnet_group" "rds-demo-subnet-group" {
  name       = "main"
  subnet_ids = [aws_subnet.rds-demo-subnet1.id, aws_subnet.rds-demo-subnet2.id]

  tags = {
    Name = "rds-demo-subnet-group"
  }
}

resource "aws_security_group" "rds-demo-security-group" {
  name        = "rds-demo-security-group"
  vpc_id      = aws_vpc.rds-demo-vpc.id

  tags = {
    Name = "rds-demo-security-group"
  }
}

resource "aws_security_group_rule_ingress" "rds-demo-sg-rule"{
security_group_id = aws_security_group.rds-demo-security_group.id
  cidr_ipv4         = aws_vpc.rds-demo-vpc.cidr_block
  from_port         = 1433
  ip_protocol       = "tcp"
  to_port           = 1433

}

resource "aws_db_parameter_group" "rds-demo-pg" {
  name        = "rds-demo-pg"
  family      = "sqlserver-ex-15.0"
  description = "Custom parameter group for SQL Server Express"

  parameter {
    name  = "max_connections"
    value = "100"
  }
}

resource "aws_db_instance" "rds-demo" {
  allocated_storage    = 20
  db_name              = "rds-demo"
  engine               = "sqlserver-ex"
  engine_version       = "15.00.4375.4.v1"
  instance_class       = "db.t3.micro"
  username             = var.rds-db-username
  password             = var.rds-db-password
  parameter_group_name = aws_db_parameter_group.rds-demo-pg.name
  skip_final_snapshot  = true
}