# Using a single workspace:
terraform {
  required_providers {
    tfe = {
      source  = "hashicorp/tfe"
      version = "0.39.0"
    }
    github = {
      source  = "integrations/github"
      version = "5.42.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "4.40.0"
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
  token = var.github_token
}

provider "tfe" {
  # Configuration options
}

provider "aws" {
  region = var.region
  # ... other configuration ...
  default_tags {
    tags = merge(
      local.base_tags,
      {
        environment = "stage"
      },
    )
  }
}

provider "aws" {
  alias  = "prod"
  region = var.region
  default_tags {
    tags = merge(
      local.base_tags,
      {
        environment = "stage"
      },
    )
  }

  assume_role {
    # The role ARN within Account B to AssumeRole into. Created in step 1.
    role_arn = "arn:aws:iam::174199678932:role/infra_role"
  }
}
