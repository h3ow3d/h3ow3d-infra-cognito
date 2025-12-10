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

# Complete Cognito configuration demonstrating all features
# This example shows production-ready configuration with multiple environments
module "cognito" {
  source = "../.."

  project_name = "h3ow3d"
  environment  = "production"

  # Google OAuth credentials
  # In production, retrieve these from AWS Secrets Manager
  google_client_id     = var.google_client_id
  google_client_secret = var.google_client_secret

  # Multiple callback URLs for different environments
  callback_urls = [
    "https://h3ow3d.com",
    "https://www.h3ow3d.com",
    "https://staging.h3ow3d.com",
    "http://localhost:3000"
  ]

  # Production domain prefix
  domain_prefix = "h3ow3d-production-auth"

  # Comprehensive tagging
  tags = {
    Project     = "h3ow3d"
    Environment = "production"
    ManagedBy   = "terraform"
    CostCenter  = "engineering"
    Compliance  = "required"
    Backup      = "daily"
  }
}

# Variables
variable "google_client_id" {
  description = "Google OAuth 2.0 client ID from Google Cloud Console"
  type        = string
  sensitive   = true
}

variable "google_client_secret" {
  description = "Google OAuth 2.0 client secret from Google Cloud Console"
  type        = string
  sensitive   = true
}

# Outputs
output "user_pool_id" {
  description = "Cognito User Pool ID for backend integration"
  value       = module.cognito.user_pool_id
}

output "client_id" {
  description = "Cognito App Client ID for frontend configuration"
  value       = module.cognito.client_id
}

output "cognito_domain" {
  description = "Full Cognito hosted UI domain"
  value       = module.cognito.domain
}

output "login_url" {
  description = "Complete login URL for the application"
  value       = "https://${module.cognito.domain}/login?client_id=${module.cognito.client_id}&response_type=token&scope=openid+email+profile&redirect_uri=https://h3ow3d.com"
}

output "logout_url" {
  description = "Complete logout URL for the application"
  value       = "https://${module.cognito.domain}/logout?client_id=${module.cognito.client_id}&logout_uri=https://h3ow3d.com"
}

# Example: How to reference this module in your deployment
# 
# In your h3ow3d-deployment repository main.tf:
#
# module "cognito" {
#   source = "git::https://github.com/h3ow3d/h3ow3d-infra-cognito.git?ref=v1.0.0"
#
#   project_name         = var.project_name
#   environment          = var.environment
#   google_client_id     = var.google_client_id
#   google_client_secret = var.google_client_secret
#   callback_urls        = ["https://h3ow3d.com"]
#   domain_prefix        = "h3ow3d-auth"
#   tags                 = local.common_tags
# }
