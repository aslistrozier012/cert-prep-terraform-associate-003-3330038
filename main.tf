# create vpc
# terraform aws create vpc
resource "aws_vpc" "my-vpc1" {
  cidr_block              = "10.0.0.0/16"
  instance_tenancy        = "default"
  enable_dns_hostnames    = true

  tags      = {
    Name    = "mydemovpc1"
  }
}


