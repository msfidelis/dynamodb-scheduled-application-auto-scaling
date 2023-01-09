resource "aws_appautoscaling_target" "read" {
  max_capacity       = var.read_capacity_max
  min_capacity       = var.read_capacity_min
  resource_id        = format("table/%s", aws_dynamodb_table.main.id)
  scalable_dimension = "dynamodb:table:ReadCapacityUnits"
  service_namespace  = "dynamodb"
}

resource "aws_appautoscaling_policy" "read" {
  name               = format("%s-autoscaling-read", var.table_name)
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.read.resource_id
  scalable_dimension = aws_appautoscaling_target.read.scalable_dimension
  service_namespace  = aws_appautoscaling_target.read.service_namespace

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "DynamoDBReadCapacityUtilization"
    }

    target_value = 70
  }
}

resource "aws_appautoscaling_scheduled_action" "read" {

  count = length(var.schedule_actions)

  name               = format("%s-%s-read-scheduled", var.table_name, lookup(var.schedule_actions[count.index], "name"))
  service_namespace  = aws_appautoscaling_target.read.service_namespace
  resource_id        = aws_appautoscaling_target.read.resource_id
  scalable_dimension = aws_appautoscaling_target.read.scalable_dimension

  schedule = lookup(var.schedule_actions[count.index], "schedule")

  scalable_target_action {
    min_capacity = lookup(var.schedule_actions[count.index], "read_min")
    max_capacity = lookup(var.schedule_actions[count.index], "read_max")
  }
}

resource "aws_appautoscaling_target" "write" {
  max_capacity       = var.write_capacity_max
  min_capacity       = var.write_capacity_min
  resource_id        = format("table/%s", aws_dynamodb_table.main.id)
  scalable_dimension = "dynamodb:table:WriteCapacityUnits"
  service_namespace  = "dynamodb"
}

resource "aws_appautoscaling_policy" "write" {
  name               = format("%s-autoscaling-write", var.table_name)
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.write.resource_id
  scalable_dimension = aws_appautoscaling_target.write.scalable_dimension
  service_namespace  = aws_appautoscaling_target.write.service_namespace

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "DynamoDBWriteCapacityUtilization"
    }

    target_value = 70
  }
}

resource "aws_appautoscaling_scheduled_action" "write" {

  count = length(var.schedule_actions)

  name               = format("%s-%s-write-scheduled", var.table_name, lookup(var.schedule_actions[count.index], "name"))
  service_namespace  = aws_appautoscaling_target.write.service_namespace
  resource_id        = aws_appautoscaling_target.write.resource_id
  scalable_dimension = aws_appautoscaling_target.write.scalable_dimension

  schedule = lookup(var.schedule_actions[count.index], "schedule")

  scalable_target_action {
    min_capacity = lookup(var.schedule_actions[count.index], "write_min")
    max_capacity = lookup(var.schedule_actions[count.index], "write_max")
  }
}
