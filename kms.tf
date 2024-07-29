resource "aws_kms_key" "demo-kms-key" {
  description = "kms key for encrypting demo resources"
  enable_key_rotation = true
  tags = {
    Name = "demo-kms-key"
  }
}

resource "aws_kms_alias" "demo-key-alias" {
  name          = "alias/demo-kms-key"
  target_key_id  = aws_kms_key.demo-kms-key.id
}

