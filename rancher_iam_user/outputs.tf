# -------------------------------

output "iam_username" {
  value       = aws_iam_user.this.name
  description = "IAM Username"
}

output "iam_arn" {
  value       = aws_iam_user.this.arn
  description = "IAM Arn"
}

output "iam_access_key" {
  value       = aws_iam_access_key.this_no_pgp.id
  description = "IAM Access Key"
}

output "iam_secret_key" {
  value       = aws_iam_access_key.this_no_pgp.secret
  description = "IAM Secret Key"
}
