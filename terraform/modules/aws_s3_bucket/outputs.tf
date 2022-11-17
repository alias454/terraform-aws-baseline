output "s3_bucket_name" {
  value       = aws_s3_bucket.s3bucket.bucket
  description = "S3 Bucket Name"
}

output "s3_bucket_id" {
  value       = aws_s3_bucket.s3bucket.id
  description = "S3 Bucket ID"
}

output "s3_bucket_arn" {
  value       = aws_s3_bucket.s3bucket.arn
  description = "S3 Bucket ARN"
}
