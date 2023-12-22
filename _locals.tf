locals {
  projects_prod = { for k, v in var.projects : k => v if v.prod_enabled == true }
}