# Using a single workspace:
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.26.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.0.1"
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

# demo, will remove
provider "aws" {
  region = "us-west-2"
}
