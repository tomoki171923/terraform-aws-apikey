# terraform-aws-apikey

Terraform module, which creates AWS apigateway api key resources.

[Terraform Registry](https://registry.terraform.io/modules/tomoki171923/apikey/aws/latest)

## Usage

```terraform
module "api_key" {
  source  = "tomoki171923/apikey/aws"
  version = "0.1.2"
  api_name   = "your_api_name"
  api_id     = "your_api_id"
  client_name = "api_client_name"
  api_keys = [
    {
      name      = "your_api_key_name_dev"
      usage_plan = "free"
    },
    {
      name      = "your_api_key_name_pro"
      usage_plan = "flex"
    }
  ]
  usage_plans = [
    {
      name        = "free"
      description = "API Development Usage Plan."
      burst_limit = 100
      rate_limit  = 200
      quota_limit = 5000
      quota_period = "DAY"
      stages      = ["dev", "st"]
    },
    {
      name        = "basic"
      description = "API Production Usage Plan. (Basic)"
      burst_limit = 100
      rate_limit  = 200
      quota_limit = 5000
      quota_period = "DAY"
      stages      = ["pro"]
    },
    {
      name        = "flex"
      description = "API Production Usage Plan. (Flex)"
      burst_limit = 500
      rate_limit  = 1000
      quota_limit = 25000
      quota_period = "DAY"
      stages      = ["pro"]
    },
    {
      name        = "premium"
      description = "API Production Usage Plan. (Premium)"
      burst_limit = 1000
      rate_limit  = 2000
      quota_limit = 50000
      quota_period = "DAY"
      stages      = ["pro"]
    }
  ]
}
```

## Examples

* [basic](https://github.com/tomoki171923/terraform-aws-apikey/tree/main/examples/basic/)

## Requirements

| Name      | Version |
| --------- | ------- |
| terraform | >= 1.0  |
| aws       | ~> 4.11 |

## Providers

| Name | Version |
| ---- | ------- |
| aws  | ~> 4.11 |

## Inputs

| Name                     | Description                                                                                                                                                                                                                                                                                                                                                                                                                              | Type                                                                                                                                                                                                     | Default                                                        | Required |
| ------------------------ | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------- | :------: |
| api_name                 | The API's name on Amazon API Gateway                                                                                                                                                                                                                                                                                                                                                                                                     | `string` | `null` |   yes    |
| api_id                   | The API's id on Amazon API Gateway                                                                                                                                                                                                                                                                                                                                                                                                       | `string` | `null` |   yes    |
| client_name              | The Client name to use this api                                                                                                                                                                                                                                                                                                                                                                                                          | `string` | `null` |    no    |
| api_keys                 | API keys. name: api key's name, usage_plan: usage plan name to attach.                                                                                                                                                                                                                                                                                                                                                                   | <pre>list(object({<br> name = string<br> usage_plan = string<br>}))</pre>                                                                                                                                | See [api_keys on variables.tf](./variables.tf)</pre>           |    no    |
| usage_plans              | API Usage plans. name: usage plan's name, description: usage plan's description, burst_limit: the api request burst limit, rate_limit: the api request steady-state rate limit, quota_limit: the maximum number of requests that can be made in a given time period, quota_period: the time period in which the limit applies. valid values are DAY, WEEK or MONTH, stages: api stage names of the associated api stage in a usage plan. | <pre>list(object({<br> name = string<br> description = string<br> burst_limit = number<br> rate_limit = number<br> quota_limit = number<br> quota_period = string<br> stages = list(string)<br>}))</pre> | See [usage_plans on variables.tf](./variables.tf)              |    no    |
| cloudwatch_metric_alarms | Acloudwatch metric alarm settings. stage_name: stage name on aws apigateway, label: label, description: alarm description, alarm_actions: cloudwatch metric alarm actions, ok_actions: cloudwatch metric ok actions, metric_name: cloudwatch metric name, period: alarms period (sec), statistic: cloudwatch metric statistic, threshold: cloudwatch metric threshold, | <pre>list(object({<br> stage_name    = string<br> label         = string<br> description   = string<br> alarm_actions = list(string)<br> ok_actions    = list(string)<br> metric_name   = string<br> period        = number<br> statistic     = string<br> threshold     = number<br>}))</pre> | See [cloudwatch_metric_alarms on variables.tf](./variables.tf) |    no    |
| tags                     | A map of tags to assign to resources.                                                                                                                                                                                                                                                                                                                                                                                                    | <pre>map(string)</pre>                                                                                                                                                                                   | {}                                                             |    no    |

## Outputs

| Name           | Description                                                                                                                                                                 |
| -------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| api_key        | Provides an API Gateway API Key. See [official](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_api_key) for details.               |
| usage_plan     | Provides an API Gateway Usage Plan. See [official](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_usage_plan) for details.         |
| usage_plan_key | Provides an API Gateway Usage Plan Key. See [official](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_usage_plan_key) for details. |
| cloudwatch_metric_alarm | CloudWatch Metric Alarm. See [official](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) for details. |

## Authors

Module managed by [tomoki171923](https://github.com/tomoki171923).

## License

MIT Licensed. See LICENSE for full details.
