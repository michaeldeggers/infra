variable "organization" {
  description = "Terraform Organization to Utilize"
  type        = string
}

variable "projects" {
  description = "Map of Projects to create Infra for"
  type        = map(any)
}

variable "environments" {
  description = "Map of Environment specific variables"
  type        = map(any)
}

variable "github_token" {
  sensitive = true
}

variable "team_api_token" {
  sensitive = true
}

variable "region" {
  default = "us-east-1"
}