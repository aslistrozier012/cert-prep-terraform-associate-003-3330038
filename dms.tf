resource "aws_iam_role" "demo-dms-role" {
  name = "demo-dms-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "dms.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_policy" "demo-dms-policy" {
  name        = "demo-dms-policy"
  description = "Policy for AWS DMS to access RDS and EC2 databases"
  policy      = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "rds:DescribeDBInstances",
          "rds:Connect",
          "rds:DescribeDBSnapshots",
          "rds:DescribeDBSubnetGroups"
        ]
        Resource = "*"
      },
      {
        Effect = "Allow"
        Action = [
          "dms:DescribeEndpoints",
          "dms:DescribeReplicationInstances",
          "dms:DescribeReplicationTasks",
          "dms:StartReplicationTask",
          "dms:StopReplicationTask",
          "dms:CreateEndpoint",
          "dms:DeleteEndpoint",
          "dms:ModifyEndpoint",
          "dms:CreateReplicationInstance",
          "dms:DeleteReplicationInstance",
          "dms:ModifyReplicationInstance"
        ]
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "dms_role_policy_attachment" {
  policy_arn = aws_iam_policy.demo-dms-policy.arn
  role       = aws_iam_role.demo-dms-role.name


}

resource "aws_dms_replication_subnet_group" "demo-dms-subnetgroup" {
  replication_subnet_group_description = "Subenet group for dms"
  replication_subnet_group_id          = "demo-dms-subnetgroup-id"

  subnet_ids = [aws_subnet.demo-subnet1.id, aws_subnet.demo-subnet2.id]

  tags = {
    Name = "demo-dms-subnetgroup"
  }
}

resource "aws_dms_replication_instance" "demo-dms-repinstance" {
  replication_instance_id      = "demo-dms-repinstance"
  replication_instance_class   = "dms.t3.micro"
  allocated_storage            = 20
  vpc_security_group_ids       = [aws_security_group.demo-ec2-sg.id]
  publicly_accessible          = false
  apply_immediately            = true
  auto_minor_version_upgrade   = true
  availability_zone            = "us-east-1c"
  engine_version               = "3.5.2"
  multi_az                     = false
  kms_key_arn                  = aws_kms_key.demo-kms-key.arn

}






/*data "aws_iam_policy_document" "demo-dms-assume-role" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      identifiers = ["dms.amazonaws.com"]
      type        = "Service"
    }
  }
}

resource "aws_iam_role" "demo-dms-endpoint-access" {
  assume_role_policy = data.aws_iam_policy_document.demo-dms-assume-role.json
  name               = "demo-dms-endpoint-access"
}


resource "aws_iam_role" "demo-dms-cloudwatch-logs-role" {
  assume_role_policy = data.aws_iam_policy_document.demo-dms-assume-role.json
  name               = "dms-cloudwatch-logs-role"
}

resource "aws_iam_role_policy_attachment" "demo-dms-cloudwatch-logs-role-AmazonDMSCloudWatchLogsRole" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonDMSCloudWatchLogsRole"
  role       = aws_iam_role.demo-dms-cloudwatch-logs-role.name
}

resource "aws_iam_role" "demo-dms-vpc-role" {
  assume_role_policy = data.aws_iam_policy_document.demo-dms-assume-role.json
  name               = "dms-vpc-role"
}

resource "aws_iam_role_policy_attachment" "demo-dms-vpc-role-AmazonDMSVPCManagementRole" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonDMSVPCManagementRole"
  role       = aws_iam_role.demo-dms-vpc-role.name
}

# Create a new replication instance
resource "aws_dms_replication_instance" "demo-dms-repinstance" {
  allocated_storage            = 20
  apply_immediately            = true
  auto_minor_version_upgrade   = true
  availability_zone            = "us-east-1a"
  engine_version               = "3.5.2"
  multi_az                     = false
  publicly_accessible          = false
  replication_instance_class   = "dms.t3.micro"
  replication_instance_id      = "demo-dms-replication-instance-tf"
  replication_subnet_group_id  = aws_dms_replication_subnet_group.test-dms-replication-subnet-group-tf.id

  tags = {
    Name = "demo-dms-repinstance"
  }

  vpc_security_group_ids = aws_security_group.
 #trying to reference from main.tf 
  depends_on = [

    aws_iam_role_policy_attachment.demo-dms-cloudwatch-logs-role-AmazonDMSCloudWatchLogsRole,
    aws_iam_role_policy_attachment.demo-dms-vpc-role-AmazonDMSVPCManagementRole
  ]
}
*/