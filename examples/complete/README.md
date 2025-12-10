# Complete Example

This example demonstrates a production-ready Cognito configuration with all features and best practices.

## What This Creates

- Cognito User Pool with comprehensive password policies
- Google Identity Provider with proper attribute mapping
- Cognito App Client with OAuth 2.0 implicit flow
- Cognito Hosted UI domain with custom prefix
- Multiple callback URLs for different environments
- Comprehensive resource tagging

## Features Demonstrated

- **Multi-environment support**: Multiple callback URLs for production, staging, and local development
- **Security best practices**: Strong password policies, email verification, case-insensitive usernames
- **Token management**: Proper token validity periods (60 min access/ID, 30 days refresh)
- **Production tagging**: Comprehensive tags for cost allocation, compliance, and backup policies
- **Integration examples**: Shows how to use in deployment repository

## Prerequisites

1. **Google OAuth Credentials** (Production)
   - Create OAuth 2.0 credentials in [Google Cloud Console](https://console.cloud.google.com/)
   - Configure authorized origins and redirect URIs
   - Store credentials in AWS Secrets Manager (recommended for production)

2. **AWS Permissions**
   - IAM permissions to create Cognito resources
   - Access to AWS Secrets Manager (if storing credentials there)

## Usage

```bash
cd examples/complete

# Option 1: Use environment variables (for testing)
export TF_VAR_google_client_id="your-google-client-id"
export TF_VAR_google_client_secret="your-google-client-secret"

# Option 2: Use AWS Secrets Manager (production recommended)
# Store your credentials in Secrets Manager first, then:
# export TF_VAR_google_client_id=$(aws secretsmanager get-secret-value --secret-id google-oauth-client-id --query SecretString --output text)
# export TF_VAR_google_client_secret=$(aws secretsmanager get-secret-value --secret-id google-oauth-client-secret --query SecretString --output text)

terraform init
terraform plan
terraform apply
```

## Testing the Setup

```bash
# Get the login and logout URLs
terraform output login_url
terraform output logout_url

# Get Cognito configuration for your frontend
terraform output user_pool_id
terraform output client_id
terraform output cognito_domain
```

## Integration with Frontend

Use the outputs in your frontend application:

```javascript
// Example React/JavaScript configuration
const cognitoConfig = {
  userPoolId: '<user_pool_id from output>',
  clientId: '<client_id from output>',
  domain: '<cognito_domain from output>',
  redirectSignIn: 'https://h3ow3d.com',
  redirectSignOut: 'https://h3ow3d.com',
  responseType: 'token',
  scope: ['openid', 'email', 'profile']
};
```

## Clean Up

```bash
terraform destroy
```

## Production Considerations

1. **Secrets Management**: Always use AWS Secrets Manager or Parameter Store for OAuth credentials
2. **Domain Prefix**: Choose a meaningful, globally unique domain prefix
3. **Callback URLs**: Only include necessary URLs; avoid exposing development URLs in production
4. **Monitoring**: Enable CloudWatch logging for Cognito (not shown in this example)
5. **Backup**: User pool data should be backed up regularly
6. **Compliance**: Ensure your configuration meets your organization's compliance requirements
