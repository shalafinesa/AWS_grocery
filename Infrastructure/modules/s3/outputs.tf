output "picture_bucket_name" {
  value       = aws_s3_bucket.picture-bucket.bucket
  description = "Name of Picture-bucket"
}
