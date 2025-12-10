# Cognito Module

Creates a Cognito User Pool, Google Identity Provider, App Client, and Hosted UI domain for authentication and authorization.

## Features

- 🔐 **User Pool**: Cognito User Pool with email verification and secure password policies
- 🌐 **Google SSO**: Integrated Google Identity Provider for social login
- 📱 **App Client**: OAuth 2.0 configured app client for web applications
- 🎨 **Hosted UI**: Cognito Hosted UI domain for ready-to-use login pages
- 🏷️ **Tagging**: Comprehensive resource tagging support

## Usage

```hcl
module "cognito" {
  source = "git::https://github.com/h3ow3d/h3ow3d-infra-cognito.git?ref=v1.0.0"

  project_name = "myapp"
  environment  = "production"

  google_client_id     = var.google_client_id
  google_client_secret = var.google_client_secret
  
  callback_urls = [
    "https://myapp.com",
    "https://www.myapp.com"
  ]
  
  domain_prefix = "myapp-auth"
  
  tags = {
    Project     = "myapp"
    Environment = "production"
    ManagedBy   = "terraform"
  }
}
```

## Examples

- [**Basic**](./examples/basic/): Minimal configuration for development
- [**Complete**](./examples/complete/): Production-ready configuration with all features

## Requirements

- Terraform >= 1.14.1
- AWS Provider >= 6.0
- Google OAuth 2.0 credentials from [Google Cloud Console](https://console.cloud.google.com/)

## Setup Google OAuth

1. Go to [Google Cloud Console](https://console.cloud.google.com/)
2. Navigate to **APIs & Services** → **Credentials**
3. Create **OAuth 2.0 Client ID**
4. Add authorized redirect URI: `https://<your-domain-prefix>.auth.<region>.amazoncognito.com/oauth2/idpresponse`
5. Note your Client ID and Client Secret

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.14.1 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 6.25.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cognito_identity_provider.google](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cognito_identity_provider) | resource |
| [aws_cognito_user_pool.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cognito_user_pool) | resource |
| [aws_cognito_user_pool_client.web](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cognito_user_pool_client) | resource |
| [aws_cognito_user_pool_domain.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cognito_user_pool_domain) | resource |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_callback_urls"></a> [callback\_urls](#input\_callback\_urls) | List of callback/logout URLs for the Cognito client | `list(string)` | n/a | yes |
| <a name="input_domain_prefix"></a> [domain\_prefix](#input\_domain\_prefix) | Domain prefix for the Cognito hosted UI (e.g. 'h3ow3d-auth') | `string` | `"h3ow3d-auth"` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment name (production, staging, development) | `string` | n/a | yes |
| <a name="input_google_client_id"></a> [google\_client\_id](#input\_google\_client\_id) | Google OAuth 2.0 client ID | `string` | n/a | yes |
| <a name="input_google_client_secret"></a> [google\_client\_secret](#input\_google\_client\_secret) | Google OAuth 2.0 client secret | `string` | n/a | yes |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | Project name used for resource naming | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Additional tags | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_client_id"></a> [client\_id](#output\_client\_id) | Cognito App Client ID |
| <a name="output_domain"></a> [domain](#output\_domain) | Cognito hosted UI domain |
| <a name="output_user_pool_id"></a> [user\_pool\_id](#output\_user\_pool\_id) | Cognito User Pool ID |
<!-- END_TF_DOCS -->
