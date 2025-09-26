resource "aws_s3_bucket" "avatars" {
  bucket = "grocerymate-avatars-finesa123"

  tags = {
    Name        = "grocerymate-avatars"
    Environment = "Dev"
  }
}