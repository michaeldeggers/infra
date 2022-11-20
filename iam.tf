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
        Resource = aws_iam_role.projects[each.key].arn
      },
    ]
  })
}

resource "aws_iam_user_policy" "eggs_cli" {
  for_each = var.projects
  name     = "eggs-cli-${each.key}-assume-role-policy"
  user     = "eggs-cli"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = "sts:AssumeRole"
        Effect   = "Allow"
        Resource = aws_iam_role.projects[each.key].arn
      },
    ]
  })
}

resource "aws_iam_access_key" "projects" {
  for_each = var.projects
  user     = aws_iam_user.projects[each.key].name
}

resource "aws_iam_role" "projects" {
  for_each = var.projects
  name     = "${var.organization}-${each.key}-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          "AWS" = [
            "arn:aws:iam::${data.aws_caller_identity.current.account_id}:user/${var.organization}-${each.key}-user",
            "arn:aws:iam::${data.aws_caller_identity.current.account_id}:user/eggs-cli"
          ]
        }
      },
    ]
  })

  # Full Rights over owned resources. TODO: Limit Scope
  inline_policy {
    name = "${var.organization}-${each.key}-policy"

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
              "aws:ResourceTag/Owner" = "${var.organization}-${each.key}"
            }
          }
        },
      ]
    })
  }

  inline_policy {
    name = "${var.organization}-${each.key}-rds-policy"

    policy = jsonencode({
      Version = "2012-10-17"
      Statement = [
        {
          Action = [
            "rds:*"
          ]
          Effect   = "Allow"
          Resource = "arn:aws:rds:${data.aws_caller_identity.current.region}:${data.aws_caller_identity.current.account_id}:*:${var.organization}-${each.key}*"
        },
        {
          Action = [
            "iam:CreateServiceLinkedRole",
            "iam:DeleteServiceLinkedRole"
          ]
          Effect   = "Allow"
          Resource = "arn:aws:iam::*:role/aws-service-role/rds.amazonaws.com/${var.organization}-${each.key}*"
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
          Resource = "arn:aws:iam::*:role/aws-service-role/rds.amazonaws.com/${var.organization}-${each.key}*"
        },
      ]
    })
  }
}

data "aws_iam_policy" "AmazonEC2FullAccess" {
  arn = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
}

resource "aws_iam_role_policy_attachment" "AmazonEC2FullAccess" {
  for_each   = var.projects
  role       = aws_iam_role.projects[each.key].name
  policy_arn = data.aws_iam_policy.AmazonEC2FullAccess.arn
}