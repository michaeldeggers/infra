variable "organization" {
  description = "Terraform Organization to Utilize"
  type        = string
}

variable "owner" {
  description = "GitHub Owner"
  type        = string
}

variable "template_repo" {
  description = "GitHub Template Repository"
  type        = string
}

variable "projects" {
  description = "Map of Projects to create Infra for"
  type        = map(any)
}

variable "github_token" {
  sensitive = true
}
