output "table_name" {
  value = aws_dynamodb_table.main.name
}

output "table_id" {
  value = aws_dynamodb_table.main.id
}

output "table_arn" {
  value = aws_dynamodb_table.main.arn
}