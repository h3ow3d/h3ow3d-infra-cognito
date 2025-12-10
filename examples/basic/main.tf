terraform {
  required_version = ">= 1.14.1"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 6.0"
    }
  }
}

provider "aws" {
  region = "eu-west-2"
}

# Basic Cognito configuration with Google SSO
module "cognito" {
  source = "../.."

  project_name = "myapp"
  environment  = "dev"

  # Google OAuth credentials (store these in AWS Secrets Manager or environment variables)
  google_client_id     = var.google_client_id
  google_client_secret = var.google_client_secret

  # Callback URLs for your application
  callback_urls = [
    "http://localhost:3000",
    "https://dev.example.com"
  ]

  # Cognito hosted UI domain prefix (must be globally unique)
  domain_prefix = "myapp-dev-auth"

  tags = {
    Project     = "myapp"
    Environment = "dev"
    ManagedBy   = "terraform"
  }
}

# Variables for sensitive data
variable "google_client_id" {
  description = "Google OAuth 2.0 client ID"
  type        = string
  sensitive   = true
  default     = "dummy-client-id-for-testing"
}

variable "google_client_secret" {
  description = "Google OAuth 2.0 client secret"
  type        = string
  sensitive   = true
  default     = "dummy-client-secret-for-testing"
}

variable "callback_urls" {
  description = "List of callback URLs for testing"
  type        = list(string)
  default     = ["http://localhost:3000"]
}

# Outputs
output "user_pool_id" {
  description = "Cognito User Pool ID"
  value       = module.cognito.user_pool_id
}

output "client_id" {
  description = "Cognito App Client ID"
  value       = module.cognito.client_id
}

output "cognito_domain" {
  description = "Cognito hosted UI domain"
  value       = module.cognito.domain
}

output "login_url" {
  description = "Cognito hosted UI login URL"
  value       = "https://${module.cognito.domain}/login?client_id=${module.cognito.client_id}&response_type=token&scope=openid+email+profile&redirect_uri=${urlencode(var.callback_urls[0])}"
}
