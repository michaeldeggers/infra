# Setup Workspaces for Projects
resource "tfe_workspace" "projects" {
  for_each     = var.projects
  name         = "${var.organization}-${each.key}${local.env_suffix}"
  organization = var.organization
  tag_names    = each.value["tags"]
}

resource "tfe_variable" "access_key" {
  for_each     = var.projects
  key          = "AWS_ACCESS_KEY"
  value        = var.access_keys[each.key].id
  category     = "env"
  sensitive    = true
  workspace_id = tfe_workspace.projects[each.key].id
  description  = "AWS Access Key"
}

resource "tfe_variable" "secret_key" {
  for_each     = var.projects
  key          = "AWS_SECRET_ACCESS_KEY"
  value        = var.access_keys[each.key].secret
  category     = "env"
  sensitive    = true
  workspace_id = tfe_workspace.projects[each.key].id
  description  = "AWS Secret Access Key"
}

resource "tfe_variable" "aws_account_id" {
  for_each     = var.projects
  key          = "aws_account_id"
  value        = var.aws_account_id
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
  value        = var.hosted_zone
  category     = "terraform"
  workspace_id = tfe_workspace.projects[each.key].id
  description  = "Project Name"
}