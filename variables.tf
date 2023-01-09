variable "table_name" {
  default     = "example-table"
  description = "Table name"
}

variable "write_capacity_min" {
  description = "Minimum Write Units"
  default     = 10
}

variable "write_capacity_max" {
  description = "Maximum Write Units"
  default     = 60
}

variable "read_capacity_min" {
  description = "Minimum Read Units"
  default     = 10
}

variable "read_capacity_max" {
  description = "Maximum Read Units"
  default     = 60
}

variable "schedule_actions" {
  description = "Scheduled Actions Configurations"
  type        = list(map(any))
  default = [
    {
      name      = "early-warmup",
      schedule  = "cron(0 7 * * ? *)"
      read_min  = 20
      read_max  = 60
      write_min = 10
      write_max = 20
    },
    {
      name      = "daily-disarm",
      schedule  = "cron(0 20 * * ? *)"
      read_min  = 1
      read_max  = 10
      write_min = 1
      write_max = 1
    },
    {
      name      = "rate",
      schedule  = "rate(5 minutes)"
      read_min  = 11
      read_max  = 50
      write_min = 11
      write_max = 21
    }
  ]
}



variable "aws_region" {
  default = "us-east-1"
}

variable "default_tags" {
  type = map(any)
  default = {
    "Environment" : "Production"
  }
}


