output "api_key" {
  sensitive = true
  value     = module.api_key.api_key
}
output "usage_plan" {
  value = module.api_key.usage_plan
}
output "usage_plan_key" {
  value = module.api_key.usage_plan_key
}
output "cloudwatch_metric_alarm" {
  value = module.api_key.cloudwatch_metric_alarm
}
