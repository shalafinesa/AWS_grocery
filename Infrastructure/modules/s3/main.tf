# Creates an S3 bucket for images (e.g. profile pictures, avatars)
resource "aws_s3_bucket" "picture-bucket" {
  bucket = var.s3_bucket_name

  tags = {
    Name        = "PictureBucket"
    Environment = var.environment
  }
}

#Blocks public access to bucket
resource "aws_s3_bucket_public_access_block" "picture_bucket_public_access" {
  bucket = aws_s3_bucket.picture-bucket.id

  block_public_acls       = true
  block_public_policy     = false
  ignore_public_acls      = true
  restrict_public_buckets = false
}

# Allows public access only to avatars folder
resource "aws_s3_bucket_policy" "avatars_public_read" {
  bucket = aws_s3_bucket.picture-bucket.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid       = "AllowPublicReadAccessToAvatars",
        Effect    = "Allow",
        Principal = "*",
        Action    = "s3:GetObject",
        Resource  = "${aws_s3_bucket.picture-bucket.arn}/avatars/*"
      }
    ]
  })
}





