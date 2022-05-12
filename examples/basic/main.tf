provider "aws" {
  region = "ap-northeast-1"
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
      usage_plan = "basic"
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
      name         = "flex",
      description  = "API Production Usage Plan.",
      burst_limit  = 300,
      rate_limit   = 600,
      quota_limit  = 15000,
      quota_period = "DAY",
      stages       = ["pro"],
    },
  ]
}
