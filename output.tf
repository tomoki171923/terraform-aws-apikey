output "api_key" {
  value = aws_api_gateway_api_key.this
}

output "usage_plan" {
  value = aws_api_gateway_usage_plan.this
}

output "usage_plan_key" {
  value = aws_api_gateway_usage_plan_key.this
}
