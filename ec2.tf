resource "aws_instance" "ec2-demoserver1"{
   ami                  = var.ami_id
   instance_type        = var.instance_type
   subnet_id            = aws_subnet.demo-subnet1.id
   security_groups      = [aws_security_group.demo-ec2-sg.name]
   availability_zone    = "us-east-1a"
   tags = {                                
     Name = "ec2-demoserver1"

}
}