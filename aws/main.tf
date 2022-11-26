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
  count = var.environment == "dev" ? 1 : 0
  name  = "eggs-cli-deploy-assume-role-policy"
  user  = "eggs-cli"

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
        {
          Action = [
            "iam:*"
          ]
          Effect = "Allow"
          Resource = [
            "arn:aws:iam::${var.aws_account_id}:role/eggs-projects-*",
            "arn:aws:iam::${var.aws_account_id}:instance-profile/eggs-projects-*"
          ]
        }
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
          Resource = "arn:aws:rds:${var.region}:${var.aws_account_id}:*:*"
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

resource "aws_iam_policy" "route53_record_updates" {
  name        = "${var.organization}-deploy-route53-policy"
  path        = "/"
  description = "Create and Update Records in Route53"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid : "AllowPublicHostedZonePermissions"
        Effect = "Allow"
        Action = [
          "route53:CreateHostedZone",
          "route53:UpdateHostedZoneComment",
          "route53:GetHostedZone",
          "route53:ListHostedZones",
          "route53:DeleteHostedZone",
          "route53:ChangeResourceRecordSets",
          "route53:ListResourceRecordSets",
          "route53:GetHostedZoneCount",
          "route53:ListHostedZonesByName",
          "route53:ListTagsForResource",
          "route53:GetChange",
          "acm:ListCertificates",
          "acm:DescribeCertificate",
          "acm:GetCertificate",
          "acm:ListTagsForCertificate"
        ],
        Resource = "*"
      },
      {
        Sid    = "AllowHealthCheckPermissions"
        Effect = "Allow"
        Action = [
          "route53:CreateHealthCheck",
          "route53:UpdateHealthCheck",
          "route53:GetHealthCheck",
          "route53:ListHealthChecks",
          "route53:DeleteHealthCheck",
          "route53:GetCheckerIpRanges",
          "route53:GetHealthCheckCount",
          "route53:GetHealthCheckStatus",
          "route53:GetHealthCheckLastFailureReason"
        ]
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "AmazonEC2FullAccess" {
  role       = aws_iam_role.deploy.name
  policy_arn = data.aws_iam_policy.AmazonEC2FullAccess.arn
}

resource "aws_iam_role_policy_attachment" "route53_record_updates" {
  role       = aws_iam_role.deploy.name
  policy_arn = aws_iam_policy.route53_record_updates.arn
}