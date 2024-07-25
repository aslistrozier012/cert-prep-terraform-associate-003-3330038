resource "aws_dms_endpoint" "ec2-source" {
  endpoint_id = "ec2-source-endpoint"
  endpoint_type = "source"
  engine_name   = "sqlserver"
  username       = var.db-username
  password       = var.db-password
  server_name     = aws_instance.ec2-demoserver1.private_ip
  port           = 1433
  database_name  = "demo-mydatabase"
}

resource "aws_dms_endpoint" "rds-target" {
  endpoint_id = "rds-target-endpoint"
  endpoint_type = "target"
  engine_name   = "sqlserver"
  username       = var.db-username
  password       = var.db-password
  server_name     = aws_db_instance.rds-demo.endpoint
  port           = 1433
  database_name  = "demo-mydatabase"
}
