resource "aws_iam_user" "projects" {
  for_each = var.projects
  name     = "${var.organization}-${each.key}-user"
}

resource "aws_iam_access_key" "projects" {
  for_each = var.projects
  user     = aws_iam_user.projects[each.key].name
}

resource "aws_iam_role" "projects" {
  for_each    = var.projects
  name_prefix = "${var.organization}-${each.key}-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          "AWS" = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:user/${var.organization}-${each.key}-user"
        }
      },
    ]
  })

  inline_policy {
    name = "${var.organization}-${each.key}-policy"

    policy = jsonencode({
      Version = "2012-10-17"
      Statement = [
        {
          Action   = ["*"]
          Effect   = "Allow"
          Resource = "arn:aws:*::${data.aws_caller_identity.current.account_id}:*/${var.organization}-${each.key}*"
        },
      ]
    })
  }
}