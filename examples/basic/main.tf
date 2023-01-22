provider "aws" {
  region = "ap-northeast-1"
}
data "aws_sns_topic" "apigateway_alarm" {
  name = "apigateway_alarm"
}

module "api_key" {
  source   = "../../"
  api_name = "sample"
  api_id   = "abcde12345"
  api_keys = [
    {
      name       = "client-a-sample-dev-key"
      usage_plan = "free"
    },
    {
      name       = "client-a-sample-pro-key"
      usage_plan = "flex"
    }
  ]
  usage_plans = [
    {
      name         = "free",
      description  = "API Development Usage Plan.",
      burst_limit  = 100,
      rate_limit   = 200,
      quota_limit  = 5000,
      quota_period = "DAY",
      stages       = ["dev", "st"],
    },
    {
      name         = "basic",
      description  = "API Production Usage Plan.",
      burst_limit  = 100,
      rate_limit   = 200,
      quota_limit  = 5000,
      quota_period = "DAY",
      stages       = ["pro"],
    },
    {
      name         = "flex",
      description  = "API Production Usage Plan.",
      burst_limit  = 300,
      rate_limit   = 600,
      quota_limit  = 15000,
      quota_period = "DAY",
      stages       = ["pro"],
    },
  ]
  cloudwatch_metric_alarms = [
    {
      stage_name    = "pro"
      label         = "call_limit"
      description   = "[production] sample API CALL count exceeded 80% of the daily limit."
      alarm_actions = [data.aws_sns_topic.apigateway_alarm.arn]
      ok_actions    = [data.aws_sns_topic.apigateway_alarm.arn]
      metric_name   = "Count"
      period        = 86400 // 1 day
      statistic     = "Sum"
      threshold     = 15000 * 0.8
    }
  ]
}
