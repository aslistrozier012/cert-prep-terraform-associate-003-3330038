resource "aws_ec2" "ec2-demo"{
   ami = "ami-016a78934c9cfa396"
   instance_type = "t2.micro"

   tags = {                                
     Name = "demo-server1"

}
}