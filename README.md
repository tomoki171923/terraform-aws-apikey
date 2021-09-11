# terraform-apigateway-apikey
Terraform module, which creates AWS apigateway api key resources.

## Usage

~~~
module "api_key" {
  source   = "git::https://github.com/tomoki171923/terraform-apigateway-apikey.git"
  api_name = "your_api_name"
  api_id   = "your_api_id"
  api_keys = [
    {
      name       = "your_api_name-dev-key"
      usage_plan = "free"
    },
    {
      name       = "your_api_name-pro-key"
      usage_plan = "flex"
    }
  ]
}

~~~