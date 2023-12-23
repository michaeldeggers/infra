#####################################################################
# AWS Dev Resources
#####################################################################
module "aws_dev" {
  source          = "./aws"
  environment     = "dev"
  organization    = var.organization
  projects        = var.projects
  aws_account_id  = var.environments.dev.account_id
  dev_account_id  = var.environments.dev.account_id
  prod_account_id = var.environments.prod.account_id
}

module "aws_prod" {
  source          = "./aws"
  environment     = "prod"
  organization    = var.organization
  projects        = local.projects_prod
  aws_account_id  = var.environments.prod.account_id
  dev_account_id  = var.environments.dev.account_id
  prod_account_id = var.environments.prod.account_id

  providers = {
    aws = aws.prod
  }
}

module "tfe_dev" {
  source         = "./tfe"
  environment    = "dev"
  organization   = var.organization
  projects       = var.projects
  aws_account_id = var.environments.dev.account_id
  hosted_zone    = var.environments.dev.hosted_zone
  access_keys    = module.aws_dev.access_keys
}

module "tfe_prod" {
  source         = "./tfe"
  environment    = "prod"
  organization   = var.organization
  projects       = local.projects_prod
  aws_account_id = var.environments.prod.account_id
  hosted_zone    = var.environments.prod.hosted_zone
  access_keys    = module.aws_prod.access_keys
}
