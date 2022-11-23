resource "aws_iam_user" "projects" {
  for_each = var.projects
  name     = "${var.organization}-${each.key}-user"
}

resource "aws_iam_user_policy" "projects" {
  for_each = var.projects
  name     = "${var.organization}-${each.key}-assume-role-policy"
  user     = aws_iam_user.projects[each.key].name

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = "sts:AssumeRole"
        Effect   = "Allow"
        Resource = aws_iam_role.deploy.arn
      },
    ]
  })
}

resource "aws_iam_user_policy" "eggs_cli" {
  name = "eggs-cli-deploy-assume-role-policy"
  user = "eggs-cli"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = "sts:AssumeRole"
        Effect   = "Allow"
        Resource = aws_iam_role.deploy.arn
      },
    ]
  })
}

resource "aws_iam_access_key" "projects" {
  for_each = var.projects
  user     = aws_iam_user.projects[each.key].name
}

locals {
  project_users     = setunion([for user in aws_iam_user.projects : user.name], ["eggs-cli"])
  project_user_arns = [for user in local.project_users : "arn:aws:iam::${data.aws_caller_identity.current.account_id}:user/${user}"]
}

resource "aws_iam_role" "deploy" {
  name = "${var.organization}-deploy-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action    = "sts:AssumeRole"
        Effect    = "Allow"
        Sid       = ""
        Principal = { "AWS" = local.project_user_arns }
      },
    ]
  })

  # Full Rights over owned resources. TODO: Limit Scope
  inline_policy {
    name = "${var.organization}-deploy-policy"

    policy = jsonencode({
      Version = "2012-10-17"
      Statement = [
        {
          Action = [
            "*",
          ]
          Effect   = "Allow"
          Resource = "*"
          Condition = {
            "StringEquals" = {
              "aws:ResourceTag/Owner" = "${var.organization}-*"
            }
          }
        },
      ]
    })
  }

  inline_policy {
    name = "${var.organization}-deploy-rds-policy"

    policy = jsonencode({
      Version = "2012-10-17"
      Statement = [
        {
          Action = [
            "rds:*"
          ]
          Effect   = "Allow"
          Resource = "arn:aws:rds:${var.region}:${data.aws_caller_identity.current.account_id}:*:${var.organization}-*"
        },
        {
          Action = [
            "iam:CreateServiceLinkedRole",
            "iam:DeleteServiceLinkedRole"
          ]
          Effect   = "Allow"
          Resource = "arn:aws:iam::*:role/aws-service-role/rds.amazonaws.com/*"
          Condition = {
            "StringLike" = {
              "iam:AWSServiceName" : "rds.amazonaws.com"
            }
          }
        },
        {
          Action = [
            "iam:AttachRolePolicy",
            "iam:PutRolePolicy"
          ]
          Effect   = "Allow"
          Resource = "arn:aws:iam::*:role/aws-service-role/rds.amazonaws.com/*"
        },
      ]
    })
  }
}

data "aws_iam_policy" "AmazonEC2FullAccess" {
  arn = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
}

resource "aws_iam_role_policy_attachment" "AmazonEC2FullAccess" {
  role       = aws_iam_role.deploy.name
  policy_arn = data.aws_iam_policy.AmazonEC2FullAccess.arn
}