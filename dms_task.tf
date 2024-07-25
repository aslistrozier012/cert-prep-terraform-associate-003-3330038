resource "aws_dms_replication_task" "demo-migration-task" {
  replication_task_id        = "demo-migration-task"
  migration_type             = "full-load-and-cdc"
  source_endpoint_arn        = aws_dms_endpoint.ec2-source.endpoint_arn
  target_endpoint_arn        = aws_dms_endpoint.rds-target.endpoint_arn
  replication_instance_arn   = aws_dms_replication_instance.demo-dms-repinstance.replication_instance_arn
  table_mappings             = jsonencode({
    rules = [
      {
        rule-type = "selection"
        rule-id   = "1"
        rule-action = "include"
        object-locator = {
          schema-name = "%"
          table-name  = "%"
        }
      }
    ]
  })
}
