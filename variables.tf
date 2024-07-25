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

/*
variable "db_username" {
  description = "Database username"
  type        = string
}

variable "db_password" {
  description = "Database password"
  type        = string
  sensitive   = true
}

variable "ami_id" {
  description = "AMI ID for EC2 instance"
  type        = string
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
*/
