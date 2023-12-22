# Infra

## Repo used to create cloud resources to support development
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 4.40.0 |
| <a name="requirement_github"></a> [github](#requirement\_github) | 5.9.1 |
| <a name="requirement_tfe"></a> [tfe](#requirement\_tfe) | 0.39.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_github"></a> [github](#provider\_github) | 5.9.1 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_aws_dev"></a> [aws\_dev](#module\_aws\_dev) | ./aws | n/a |
| <a name="module_aws_prod"></a> [aws\_prod](#module\_aws\_prod) | ./aws | n/a |
| <a name="module_tfe_dev"></a> [tfe\_dev](#module\_tfe\_dev) | ./tfe | n/a |
| <a name="module_tfe_prod"></a> [tfe\_prod](#module\_tfe\_prod) | ./tfe | n/a |

## Resources

| Name | Type |
|------|------|
| [github_actions_secret.tf_api_token](https://registry.terraform.io/providers/integrations/github/5.9.1/docs/resources/actions_secret) | resource |
| [github_repository.projects](https://registry.terraform.io/providers/integrations/github/5.9.1/docs/resources/repository) | resource |
| [github_repository_environment.dev](https://registry.terraform.io/providers/integrations/github/5.9.1/docs/resources/repository_environment) | resource |
| [github_repository_environment.prod](https://registry.terraform.io/providers/integrations/github/5.9.1/docs/resources/repository_environment) | resource |
| [github_user.current](https://registry.terraform.io/providers/integrations/github/5.9.1/docs/data-sources/user) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_environments"></a> [environments](#input\_environments) | Map of Environment specific variables | `map(any)` | n/a | yes |
| <a name="input_github_token"></a> [github\_token](#input\_github\_token) | n/a | `any` | n/a | yes |
| <a name="input_organization"></a> [organization](#input\_organization) | Terraform Organization to Utilize | `string` | n/a | yes |
| <a name="input_projects"></a> [projects](#input\_projects) | Map of Projects to create Infra for | `map(any)` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | `"us-east-1"` | no |
| <a name="input_team_api_token"></a> [team\_api\_token](#input\_team\_api\_token) | n/a | `any` | n/a | yes |

## Outputs

No outputs.
