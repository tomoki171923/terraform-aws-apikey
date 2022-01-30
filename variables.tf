variable "api_name" {
  description = "rest api name on aws apigateway"
  type        = string
  default     = null
}

variable "api_id" {
  description = "rest api id on aws apigateway"
  type        = string
  default     = null
}

variable "client_name" {
  description = "client name to use rest api"
  type        = string
  default     = ""
}

variable "api_keys" {
  description = "api keys"
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
  description = "api usage plans"
  type = object({
    free = object({
      description  = string
      burst_limit  = number
      rate_limit   = number
      quota_limit  = number
      quota_period = string
      stages       = list(string)
    })
    basic = object({
      description  = string
      burst_limit  = number
      rate_limit   = number
      quota_limit  = number
      quota_period = string
      stages       = list(string)
    })
    flex = object({
      description  = string
      burst_limit  = number
      rate_limit   = number
      quota_limit  = number
      quota_period = string
      stages       = list(string)
    })
    premium = object({
      description  = string
      burst_limit  = number
      rate_limit   = number
      quota_limit  = number
      quota_period = string
      stages       = list(string)
    })
  })
  default = {
    free = {
      description  = "API Development Usage Plan."
      burst_limit  = 20
      rate_limit   = 40
      quota_limit  = 1000
      quota_period = "DAY"
      stages       = ["dev", "st"]
    }
    basic = {
      description  = "API Production Usage Plan. (Basic)"
      burst_limit  = 20
      rate_limit   = 40
      quota_limit  = 1000
      quota_period = "DAY"
      stages       = ["pro"]
    }
    flex = {
      description  = "API Production Usage Plan. (Flex)"
      burst_limit  = 100
      rate_limit   = 200
      quota_limit  = 5000
      quota_period = "DAY"
      stages       = ["pro"]
    }
    premium = {
      description  = "API Production Usage Plan. (Premium)"
      burst_limit  = 400
      rate_limit   = 200
      quota_limit  = 10000
      quota_period = "DAY"
      stages       = ["pro"]
    }
  }
}
