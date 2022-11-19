resource "tfe_team" "dev" {
  name         = "devs"
  organization = "eggs-projects"
}

resource "tfe_team_token" "dev" {
  team_id = tfe_team.dev.id
}

resource "tfe_workspace" "projects" {
  for_each     = var.projects
  name         = each.key
  organization = "eggs-projects"
  tag_names    = each.value["tags"]
}

# Setup Repos for Projects
resource "github_repository" "projects" {
  for_each    = var.projects
  name        = each.key
  description = each.value["description"]

  visibility = "private"

  template {
    owner                = "michaeldeggers"
    repository           = "repo_template"
    include_all_branches = false
  }
}

resource "github_actions_secret" "example_secret" {
  for_each        = var.projects
  repository      = each.key
  secret_name     = "TF_API_TOKEN"
  plaintext_value = tfe_team_token.dev.token
}