# Setup Workspaces for Projects
resource "tfe_workspace" "projects" {
  for_each     = var.projects
  name         = "${var.organization}-${each.key}"
  organization = var.organization
  tag_names    = each.value["tags"]
}

resource "tfe_variable" "access_key" {
  for_each     = var.projects
  key          = "AWS_ACCESS_KEY"
  value        = aws_iam_access_key.projects[each.key].id
  category     = "env"
  sensitive    = true
  workspace_id = tfe_workspace.projects[each.key].id
  description  = "AWS Access Key"
}

resource "tfe_variable" "secret_key" {
  for_each     = var.projects
  key          = "AWS_SECRET_ACCESS_KEY"
  value        = aws_iam_access_key.projects[each.key].secret
  category     = "env"
  sensitive    = true
  workspace_id = tfe_workspace.projects[each.key].id
  description  = "AWS Secret Access Key"
}

resource "tfe_variable" "aws_account_id" {
  for_each     = var.projects
  key          = "aws_account_id"
  value        = data.aws_caller_identity.current.account_id
  category     = "terraform"
  workspace_id = tfe_workspace.projects[each.key].id
  description  = "AWS Account ID"
}

resource "tfe_variable" "organization" {
  for_each     = var.projects
  key          = "organization"
  value        = var.organization
  category     = "terraform"
  workspace_id = tfe_workspace.projects[each.key].id
  description  = "Project Organization"
}

resource "tfe_variable" "project_name" {
  for_each     = var.projects
  key          = "project_name"
  value        = each.key
  category     = "terraform"
  workspace_id = tfe_workspace.projects[each.key].id
  description  = "Project Name"
}

resource "tfe_variable" "route53_hosted_zone_name" {
  for_each     = var.projects
  key          = "route53_hosted_zone_name"
  value        = var.environments[each.value["tfe"]["environments"][0]]["hosted_zone"]
  category     = "terraform"
  workspace_id = tfe_workspace.projects[each.key].id
  description  = "Project Name"
}