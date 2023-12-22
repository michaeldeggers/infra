locals {
  project_users     = var.environment == "dev" ? setunion([for user in aws_iam_user.projects : user.name], ["eggs-cli"]) : [for user in aws_iam_user.projects : user.name]
  project_user_arns = [for user in local.project_users : "arn:aws:iam::${var.aws_account_id}:user/${user}"]
}