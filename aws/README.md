## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 4.40.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.40.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_access_key.projects](https://registry.terraform.io/providers/hashicorp/aws/4.40.0/docs/resources/iam_access_key) | resource |
| [aws_iam_policy.route53_record_updates](https://registry.terraform.io/providers/hashicorp/aws/4.40.0/docs/resources/iam_policy) | resource |
| [aws_iam_role.deploy](https://registry.terraform.io/providers/hashicorp/aws/4.40.0/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.AmazonEC2FullAccess](https://registry.terraform.io/providers/hashicorp/aws/4.40.0/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.route53_record_updates](https://registry.terraform.io/providers/hashicorp/aws/4.40.0/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_user.projects](https://registry.terraform.io/providers/hashicorp/aws/4.40.0/docs/resources/iam_user) | resource |
| [aws_iam_user_policy.eggs_cli](https://registry.terraform.io/providers/hashicorp/aws/4.40.0/docs/resources/iam_user_policy) | resource |
| [aws_iam_user_policy.projects](https://registry.terraform.io/providers/hashicorp/aws/4.40.0/docs/resources/iam_user_policy) | resource |
| [aws_iam_policy.AmazonEC2FullAccess](https://registry.terraform.io/providers/hashicorp/aws/4.40.0/docs/data-sources/iam_policy) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_account_id"></a> [aws\_account\_id](#input\_aws\_account\_id) | AWS Account ID for the chosen environment | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | Deployment Environment (dev, prod) | `string` | n/a | yes |
| <a name="input_organization"></a> [organization](#input\_organization) | Terraform Organization to Utilize | `string` | n/a | yes |
| <a name="input_projects"></a> [projects](#input\_projects) | Attributes of the project | <pre>map(object({<br>    description = string<br>    tags        = list(string)<br>    visibility  = string<br>    template    = map(any)<br>  }))</pre> | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | `"us-east-1"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_access_keys"></a> [access\_keys](#output\_access\_keys) | Access Keys for Project Users |
