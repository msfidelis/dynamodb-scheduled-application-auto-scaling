# DynamoDB Application Autoscaling Example

Simple repo to explain how to implement Auto Scaling Actions on DynamoDB Tables, including scheduled actions to warm up workloads to predicted high throughput variation. 


<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.49.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_appautoscaling_policy.read](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appautoscaling_policy) | resource |
| [aws_appautoscaling_policy.write](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appautoscaling_policy) | resource |
| [aws_appautoscaling_scheduled_action.read](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appautoscaling_scheduled_action) | resource |
| [aws_appautoscaling_scheduled_action.write](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appautoscaling_scheduled_action) | resource |
| [aws_appautoscaling_target.read](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appautoscaling_target) | resource |
| [aws_appautoscaling_target.write](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appautoscaling_target) | resource |
| [aws_dynamodb_table.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dynamodb_table) | resource |
| [aws_kms_key.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | n/a | `string` | `"us-east-1"` | no |
| <a name="input_default_tags"></a> [default\_tags](#input\_default\_tags) | n/a | `map(any)` | <pre>{<br>  "Environment": "Production"<br>}</pre> | no |
| <a name="input_read_capacity_max"></a> [read\_capacity\_max](#input\_read\_capacity\_max) | Maximum Read Units | `number` | `60` | no |
| <a name="input_read_capacity_min"></a> [read\_capacity\_min](#input\_read\_capacity\_min) | Minimum Read Units | `number` | `10` | no |
| <a name="input_schedule_actions"></a> [schedule\_actions](#input\_schedule\_actions) | Scheduled Actions Configurations | `list(map(any))` | <pre>[<br>  {<br>    "name": "early-warmup",<br>    "read_max": 60,<br>    "read_min": 20,<br>    "schedule": "cron(0 7 * * ? *)",<br>    "write_max": 20,<br>    "write_min": 10<br>  },<br>  {<br>    "name": "daily-disarm",<br>    "read_max": 10,<br>    "read_min": 1,<br>    "schedule": "cron(0 20 * * ? *)",<br>    "write_max": 1,<br>    "write_min": 1<br>  },<br>  {<br>    "name": "rate",<br>    "read_max": 50,<br>    "read_min": 11,<br>    "schedule": "rate(5 minutes)",<br>    "write_max": 21,<br>    "write_min": 11<br>  }<br>]</pre> | no |
| <a name="input_table_name"></a> [table\_name](#input\_table\_name) | Table name | `string` | `"example-table"` | no |
| <a name="input_write_capacity_max"></a> [write\_capacity\_max](#input\_write\_capacity\_max) | Maximum Write Units | `number` | `60` | no |
| <a name="input_write_capacity_min"></a> [write\_capacity\_min](#input\_write\_capacity\_min) | Minimum Write Units | `number` | `10` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_table_arn"></a> [table\_arn](#output\_table\_arn) | n/a |
| <a name="output_table_id"></a> [table\_id](#output\_table\_id) | n/a |
| <a name="output_table_name"></a> [table\_name](#output\_table\_name) | n/a |
<!-- END_TF_DOCS -->