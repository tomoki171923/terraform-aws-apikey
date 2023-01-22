variable "api_name" {
  description = "api name on aws apigateway."
  type        = string
}

variable "alarms" {
  description = <<EOF
  cloudwatch metric alarm settings.
    stage_name: stage name on aws apigateway,
    label: label,
    description: alarm description,
    alarm_actions: cloudwatch metric alarm actions,
    ok_actions: cloudwatch metric ok actions,
    metric_name: cloudwatch metric name,
    period: alarms period (sec),
    statistic: cloudwatch metric statistic,
    threshold: cloudwatch metric threshold,
EOF
  type = list(
    object({
      stage_name    = string
      label         = string
      description   = string
      alarm_actions = list(string)
      ok_actions    = list(string)
      metric_name   = string
      period        = number
      statistic     = string
      threshold     = number
    })
  )
}

variable "tags" {
  description = "A map of tags to assign to resources."
  type        = map(string)
  default     = {}
}
