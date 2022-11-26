# variable "organization"
variable "aws_account_id" {
  description = "AWS Account ID for the chosen environment"
  type        = string
}

# variable "organization"
variable "environment" {
  description = "Deployment Environment (dev, prod)"
  type        = string
  default     = "dev"
}

variable "hosted_zone" {
  description = "Route53 Hosted Zone for the chosen environment"
  type        = string
}

# variable "organization"
variable "organization" {
  description = "Terraform Organization to Utilize"
  type        = string
}

variable "projects" {
  description = "Attributes of the project"
  type = map(object({
    description = string
    tags        = list(string)
    visibility  = string
    template    = map(any)
  }))
}

variable "region" {
  default = "us-east-1"
}

variable "access_keys" {
  sensitive = true
  type      = map(any)
}