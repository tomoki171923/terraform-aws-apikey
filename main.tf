# ********************************* #
# API Keys on API Gateway
# ref: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_api_key
# ********************************* #


/*
    API Keys
*/
locals {
  tags = {
    Terraform = true
    API       = var.api_name
  }
}
resource "aws_api_gateway_api_key" "this" {
  for_each = {
    for key in var.api_keys : key.name => {
      name = key.name
    }
  }
  name = each.value.name
  tags = merge(local.tags, var.tags)
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

      name         = string
      description  = string
      burst_limit  = number
      rate_limit   = number
      quota_limit  = number
      quota_period = string
      stages       = list(string)
*/
resource "aws_api_gateway_usage_plan" "this" {
  for_each = {
    for key in var.usage_plans : key.name => {
      name         = key.name
      description  = key.description
      burst_limit  = key.burst_limit
      rate_limit   = key.rate_limit
      quota_limit  = key.quota_limit
      quota_period = key.quota_period
      stages       = key.stages
    }
  }
  # for_each    = var.usage_plans
  name        = var.client_name == null ? "${var.api_name}-${each.value.name}" : "${var.client_name}-${var.api_name}-${each.value.name}"
  description = var.client_name == null ? "${var.api_name} ${each.value.description}" : "${var.api_name} ${each.value.description} for ${var.client_name}."
  # product_code = "MYCODE"

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

module "cloudwatch_metric_alarm" {
  count    = var.cloudwatch_metric_alarms == [] ? 0 : 1
  source   = "./modules/cloudwatch_metric_alarm/"
  api_name = var.api_name
  alarms   = var.cloudwatch_metric_alarms
  tags     = var.tags
}
