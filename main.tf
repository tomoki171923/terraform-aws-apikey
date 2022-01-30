# ********************************* #
# API Keys on API Gateway
# ref: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_api_key
# ********************************* #


/*
    API Keys
*/
resource "aws_api_gateway_api_key" "this" {
  for_each = {
    for key in var.api_keys : key.name => {
      name = key.name
    }
  }
  name = each.value.name
}

resource "aws_api_gateway_usage_plan_key" "this" {
  for_each = {
    for key in var.api_keys : key.name => {
      name       = key.name
      usage_plan = key.usage_plan
    }
  }
  key_id        = aws_api_gateway_api_key.this[each.key].id
  key_type      = "API_KEY"
  usage_plan_id = aws_api_gateway_usage_plan.this[each.value.usage_plan].id
  depends_on = [
    aws_api_gateway_api_key.this,
    aws_api_gateway_usage_plan.this,
  ]
}


# ********************************* #
# Usage Plans on API Gateway
# ref: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_usage_plan
# ********************************* #


/*
    API Usage Plans
*/
resource "aws_api_gateway_usage_plan" "this" {
  for_each    = var.usage_plans
  name        = var.client_name == null ? "${var.api_name}-${each.key}" : "${var.client_name}-${var.api_name}-${each.key}"
  description = var.client_name == null ? "${var.api_name} ${each.value.description}" : "${var.api_name} ${each.value.description} for ${var.client_name}."
  #product_code = "MYCODE"

  dynamic "api_stages" {
    for_each = each.value.stages
    content {
      api_id = var.api_id
      stage  = api_stages.value
    }
  }

  throttle_settings {
    burst_limit = each.value.burst_limit
    rate_limit  = each.value.rate_limit
  }

  quota_settings {
    limit  = each.value.quota_limit
    period = each.value.quota_period
  }
}
