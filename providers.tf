# Using a single workspace:
terraform {
  required_providers {
    tfe = {
      source  = "hashicorp/tfe"
      version = "0.39.0"
    }
    github = {
      source  = "integrations/github"
      version = "5.9.0"
    }
  }
  required_version = ">= 1.1.0"

  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "eggs-projects"

    workspaces {
      name = "infra"
    }
  }
}

provider "github" {
  # Configuration options
}