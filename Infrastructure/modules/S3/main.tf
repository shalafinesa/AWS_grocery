resource "random_id" "bucket_id" {
  byte_length = 4
}

resource "aws_s3_bucket" "grocery_bucket" {
  bucket = "${var.bucket_prefix}-${random_id.bucket_id.hex}"
  acl    = var.bucket_acl
}
