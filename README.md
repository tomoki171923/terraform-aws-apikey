# terraform-aws-apikey

Terraform module, which creates AWS apigateway api key resources.

## For User

### Usage

```terraform
module "api_key" {
  source     = "git::https://github.com/tomoki171923/terraform-aws-apikey.git?ref=v0.1.0"
  api_name   = "your_api_name"
  api_id     = "your_api_id"
  client_name = "api_client_name"
  api_keys = [
    {
      name      = "your_api_name-dev-key"
      usage_plan = "free"
    },
    {
      name      = "your_api_name-pro-key"
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

| Name        | Description                                                                                                                                                                                                                                                                                                                                                                                                                              | Type                                                                                                                                                                                                     | Default                                                                                                                                                           | Required |
| ----------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------- | :------: |
| api_name    | The API's name on Amazon API Gateway                                                                                                                                                                                                                                                                                                                                                                                                     | `string` | `""` |   yes    |
| api_id      | The API's id on Amazon API Gateway                                                                                                                                                                                                                                                                                                                                                                                                       | `string` | `""` |   yes    |
| client_name | The Client name to use this api                                                                                                                                                                                                                                                                                                                                                                                                          | `string` | `""` |   yes    |
| api_keys    | API keys. name: api key's name, usage_plan: usage plan name to attach.                                                                                                                                                                                                                                                                                                                                                                   | <pre>list(object({<br> name = string<br> usage_plan = string<br>}))</pre>                                                                                                                                | <pre>[<br> {<br> name = "client-a-dev-key", <br> usage_plan = "free", <br> }, <br> {<br> name = "client-a-pro-key", <br> usage_plan = "flex", <br> }, <br>]</pre> |    no    |
| usage_plans | API Usage plans. name: usage plan's name, description: usage plan's description, burst_limit: the api request burst limit, rate_limit: the api request steady-state rate limit, quota_limit: the maximum number of requests that can be made in a given time period, quota_period: the time period in which the limit applies. valid values are DAY, WEEK or MONTH, stages: api stage names of the associated api stage in a usage plan. | <pre>list(object({<br> name = string<br> description = string<br> burst_limit = number<br> rate_limit = number<br> quota_limit = number<br> quota_period = string<br> stages = list(string)<br>}))</pre> | <pre>[<br> {<br> name = "client-a-dev-key", <br> usage_plan = "free", <br> }, <br> {<br> name = "client-a-pro-key", <br> usage_plan = "flex", <br> }, <br>]</pre> |    no    |

## Outputs

| Name               | Description                                                                                                                                                               |
| ------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| rest_api           | REST API's Attributes. See [official](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_rest_api#attributes-reference) for details. |
| deployments        | Attributes of deployments. See [official](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_deployment) for details.                |
| stages             | Attributes of stages. See [official](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_stage) for details.                          |
| methods            | Attributes of API Methods. See [official](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_method_settings) for details.           |
| lambda_permissions | Attributes of Lambda Permission. See [official](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_permission) for details.               |
| log_groups         | Attributes of CloudWatch LogGroups. See [official](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) for details.         |

## Authors

Module managed by [tomoki171923](https://github.com/tomoki171923).

## License

MIT Licensed. See LICENSE for full details.

## For Contributor

### set pre-commit

```bash
brew install pre-commit
pre-commit install
```
