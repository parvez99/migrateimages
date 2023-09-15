output "legacy_bucket_id" {
  description = "legacy bucket."
  value       = aws_s3_bucket.legacy-s3.id
}

output "production_bucket_id" {
  description = "production bucket"
  value       = aws_s3_bucket.production-s3.id
}

output "legacy_bucket_arn" {
  description = "The ARN of legacy bucket"
  value       = aws_s3_bucket.legacy-s3.arn
}

output "production_bucket_arn" {
  description = "The ARN of production bucket"
  value       = aws_s3_bucket.production-s3.arn
}

output "iam_role_arn" {
  description = "The ARN of IAM role"
  value       = aws_iam_role.this.arn
}