# Setup Repos for Projects
resource "github_repository" "projects" {
  for_each    = var.projects
  name        = each.key
  description = each.value["description"]

  visibility = each.value["visibility"]
  security_and_analysis {
    advanced_security {
      status = each.value["advanced_security"]
    }
    secret_scanning_push_protection {
      status = each.value["secret_scanning_push_protection"]
    }
    secret_scanning {
      status = each.value["secret_scanning"]
    }
  }

  template {
    owner                = each.value["template"]["owner"]
    repository           = each.value["template"]["repo"]
    include_all_branches = false
  }
}

resource "github_actions_secret" "tf_api_token" {
  for_each        = var.projects
  repository      = github_repository.projects[each.key].name
  secret_name     = "TF_API_TOKEN"
  plaintext_value = var.team_api_token
}

resource "github_repository_environment" "dev" {
  for_each    = local.projects_prod
  environment = "dev"
  repository  = github_repository.projects[each.key].name

  deployment_branch_policy {
    protected_branches     = true
    custom_branch_policies = false
  }
}

resource "github_repository_environment" "prod" {
  for_each    = local.projects_prod
  environment = "prod"
  repository  = github_repository.projects[each.key].name
  reviewers {
    users = [data.github_user.current.id]
  }
  deployment_branch_policy {
    protected_branches     = true
    custom_branch_policies = false
  }
}