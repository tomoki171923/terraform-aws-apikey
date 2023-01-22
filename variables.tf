variable "api_name" {
  description = "api name on aws apigateway."
  type        = string
  default     = null
}

variable "api_id" {
  description = "api id on aws apigateway."
  type        = string
  default     = null
}

variable "client_name" {
  description = "client name to use this api."
  type        = string
  default     = null
}

variable "api_keys" {
  description = "api keys. name: api key's name, usage_plan: usage plan name to attach."
  type = list(
    object({
      name       = string
      usage_plan = string
    })
  )
  default = [
    {
      name       = "dev-key"
      usage_plan = "free"
    },
    {
      name       = "pro-key"
      usage_plan = "basic"
    }
  ]
}

variable "usage_plans" {
  description = <<EOF
  api usage plans.
    name: usage plan's name,
    description: usage plan's description,
    burst_limit: the api request burst limit,
    rate_limit: the api request steady-state rate limit,
    quota_limit: the maximum number of requests that can be made in a given time period,
    quota_period: the time period in which the limit applies. valid values are DAY, WEEK or MONTH,
    stages: api stage names of the associated api stage in a usage plan.
EOF
  type = list(
    object({
      name         = string
      description  = string
      burst_limit  = number
      rate_limit   = number
      quota_limit  = number
      quota_period = string
      stages       = list(string)
    })
  )
  default = [
    {
      name         = "free"
      description  = "API Development Usage Plan."
      burst_limit  = 20
      rate_limit   = 40
      quota_limit  = 1000
      quota_period = "DAY"
      stages       = ["dev", "st"]
    },
    {
      name         = "basic"
      description  = "API Production Usage Plan. (Basic)"
      burst_limit  = 20
      rate_limit   = 40
      quota_limit  = 1000
      quota_period = "DAY"
      stages       = ["pro"]
    },
    {
      name         = "flex"
      description  = "API Production Usage Plan. (Flex)"
      burst_limit  = 100
      rate_limit   = 200
      quota_limit  = 5000
      quota_period = "DAY"
      stages       = ["pro"]
    },
    {
      name         = "premium"
      description  = "API Production Usage Plan. (Premium)"
      burst_limit  = 200
      rate_limit   = 400
      quota_limit  = 10000
      quota_period = "DAY"
      stages       = ["pro"]
    }
  ]
}

variable "tags" {
  description = "A map of tags to assign to resources."
  type        = map(string)
  default     = {}
}
