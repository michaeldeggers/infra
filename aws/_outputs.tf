output "access_keys" {
  sensitive   = true
  value       = aws_iam_access_key.projects
  description = "Access Keys for Project Users"
}