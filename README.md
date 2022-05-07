<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents**

- [terraform-aws-apikey](#terraform-aws-apikey)
  - [For User](#for-user)
    - [Usage](#usage)
  - [Authors](#authors)
  - [License](#license)
  - [For Contributor](#for-contributor)
    - [set pre-commit](#set-pre-commit)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

# terraform-aws-apikey

Terraform module, which creates AWS apigateway api key resources.

## For User

### Usage

```terraform
module "api_key" {
  source      = "git::https://github.com/tomoki171923/terraform-aws-apikey.git?ref=v0.1.0"
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
```

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
