locals {
  projects_prod = { for k, v in var.projects : k => v if v.prod_enabled == true }

  # recommended aws tags to use for aws terraform provider
  base_tags = {
    github_repo = "infra"
    github_org  = "michaeldeggers"
  }
}
