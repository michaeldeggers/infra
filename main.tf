# Setup Workspaces for Projects
resource "tfe_workspace" "projects" {
  for_each     = var.projects
  name         = "${var.organization}-${each.key}"
  organization = var.organization
  tag_names    = each.value["tags"]
}

# Setup Repos for Projects
resource "github_repository" "projects" {
  for_each    = var.projects
  name        = each.key
  description = each.value["description"]

  visibility = each.value["visibility"]

  template {
    owner                = var.owner
    repository           = var.template_repo
    include_all_branches = false
  }
}

resource "github_actions_secret" "tf_api_token" {
  for_each        = var.projects
  repository      = each.key
  secret_name     = "TF_API_TOKEN"
  plaintext_value = var.team_api_token
}