<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents**

- [terraform-apigateway-apikey](#terraform-apigateway-apikey)
  - [Usage](#usage)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

# terraform-apigateway-apikey

Terraform module, which creates AWS apigateway api key resources.

## Usage

~~~
module "api_key" {
  source      = "git::https://github.com/tomoki171923/terraform-apigateway-apikey.git"
  api_name    = "your_api_name"
  api_id      = "your_api_id"
  client_name = "api_client_name"
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
