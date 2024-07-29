variable "db-username" {
  type = string
  description = "username for rds-demo db instance"
  default = "admin"
}

variable "db-password" {
  type = string
  description = "username for rds-demo db instance"
  default = "demordspass1"
}

variable "ami_id" {
  description = "AMI ID for EC2 instance"
  type        = string
  default     = "ami-016a78934c9cfa396"
}

variable "instance_type" {
  description = "Instance type for EC2 and RDS"
  type        = string
  default     = "t3.micro"
}

variable "db_instance_type" {
  description = "DB instance type for RDS"
  type        = string
  default     = "db.t3.micro"
}
