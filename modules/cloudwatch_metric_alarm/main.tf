resource "aws_cloudwatch_metric_alarm" "this" {
  for_each = {
    for key in var.alarms : key.stage_name => {
      stage_name    = key.stage_name
      label         = key.label
      description   = key.description
      alarm_actions = key.alarm_actions
      ok_actions    = key.ok_actions
      metric_name   = key.metric_name
      period        = key.period
      statistic     = key.statistic
      threshold     = key.threshold
    }
  }
  actions_enabled     = true
  alarm_actions       = each.value.alarm_actions
  alarm_name          = "apigateway_${var.api_name}_${each.value.stage_name}_${each.value.label}_alarm"
  alarm_description   = each.value.description
  comparison_operator = "GreaterThanOrEqualToThreshold"
  datapoints_to_alarm = 1
  dimensions = {
    ApiName = var.api_name
    Stage   = each.value.stage_name
  }
  evaluation_periods = 1
  metric_name        = each.value.metric_name
  namespace          = "AWS/ApiGateway"
  ok_actions         = each.value.ok_actions
  period             = each.value.period
  statistic          = each.value.statistic
  threshold          = each.value.threshold
  treat_missing_data = "missing"
  tags               = var.tags
}
