# AWS Moved Resources
moved {
  from = aws_iam_user.projects
  to   = module.aws_dev.aws_iam_user.projects
}

moved {
  from = aws_iam_user_policy.projects
  to   = module.aws_dev.aws_iam_user_policy.projects
}

moved {
  from = aws_iam_user_policy.eggs_cli
  to   = module.aws_dev.aws_iam_user_policy.eggs_cli
}

moved {
  from = aws_iam_access_key.projects
  to   = module.aws_dev.aws_iam_access_key.projects
}

moved {
  from = aws_iam_role.deploy
  to   = module.aws_dev.aws_iam_role.deploy
}

moved {
  from = aws_iam_policy.route53_record_updates
  to   = module.aws_dev.aws_iam_policy.route53_record_updates
}

moved {
  from = aws_iam_role_policy_attachment.AmazonEC2FullAccess
  to   = module.aws_dev.aws_iam_role_policy_attachment.AmazonEC2FullAccess
}

moved {
  from = aws_iam_role_policy_attachment.route53_record_updates
  to   = module.aws_dev.aws_iam_role_policy_attachment.route53_record_updates
}

moved {
  from = tfe_workspace.projects
  to   = module.tfe_dev.tfe_workspace.projects
}

moved {
  from = tfe_variable.access_key
  to   = module.tfe_dev.tfe_variable.access_key
}

moved {
  from = tfe_variable.secret_key
  to   = module.tfe_dev.tfe_variable.secret_key
}

moved {
  from = tfe_variable.aws_account_id
  to   = module.tfe_dev.tfe_variable.aws_account_id
}

moved {
  from = tfe_variable.organization
  to   = module.tfe_dev.tfe_variable.organization
}

moved {
  from = tfe_variable.project_name
  to   = module.tfe_dev.tfe_variable.project_name
}

# Terraform Cloud Moved Resources
moved {
  from = tfe_variable.route53_hosted_zone_name
  to   = module.tfe_dev.tfe_variable.route53_hosted_zone_name
}