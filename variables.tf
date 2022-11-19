variable "projects" {
  description = "Map of Projects to create Infra for"
  type        = map(any)
}

variable "github_token" {
  sensitive = true
}
