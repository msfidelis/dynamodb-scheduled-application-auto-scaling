resource "aws_dynamodb_table" "main" {
  name           = var.table_name
  billing_mode   = "PROVISIONED"
  read_capacity  = var.read_capacity_min
  write_capacity = var.write_capacity_min

  hash_key = "UUID"

  attribute {
    name = "UUID"
    type = "S"
  }

  ttl {
    attribute_name = "TTL"
    enabled        = true
  }

  lifecycle {
    ignore_changes = [
        read_capacity,
        write_capacity
    ]
  }

  server_side_encryption {
    enabled = true
    kms_key_arn = aws_kms_key.main.arn
  }

}
