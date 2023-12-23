# variable "organization"
variable "aws_account_id" {
  description = "AWS Account ID for the chosen environment"
  type        = string
}

# variable "organization"
variable "environment" {
  description = "Deployment Environment (dev, prod)"
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

variable "dev_account_id" {
  description = "dev account id"
  type        = string
}
variable "prod_account_id" {
  description = "prod account id"
  type        = string
}