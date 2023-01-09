resource "aws_kms_key" "main" {
  description             = var.table_name
}