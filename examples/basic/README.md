# Basic Example

This example demonstrates a minimal Cognito configuration with Google SSO for a development environment.

## What This Creates

- Cognito User Pool with email verification
- Google Identity Provider integration
- Cognito App Client for web applications
- Cognito Hosted UI domain

## Prerequisites

1. **Google OAuth Credentials**: Create OAuth 2.0 credentials in [Google Cloud Console](https://console.cloud.google.com/)
   - Go to APIs & Services → Credentials
   - Create OAuth 2.0 Client ID
   - Add authorized redirect URIs: `https://<your-domain-prefix>.auth.<region>.amazoncognito.com/oauth2/idpresponse`

2. **AWS Credentials**: Ensure your AWS credentials are configured

## Usage

```bash
cd examples/basic

# Set your Google OAuth credentials as environment variables
export TF_VAR_google_client_id="your-google-client-id"
export TF_VAR_google_client_secret="your-google-client-secret"

terraform init
terraform plan
terraform apply
```

## Testing the Setup

After deployment, you can test the login flow:

```bash
# The login URL will be in the outputs
terraform output login_url

# Open the URL in a browser to test Google sign-in
```

## Clean Up

```bash
terraform destroy
```

## Notes

- The `domain_prefix` must be globally unique across all AWS accounts
- Callback URLs include localhost for local development
- All sensitive credentials should be stored in AWS Secrets Manager in production
