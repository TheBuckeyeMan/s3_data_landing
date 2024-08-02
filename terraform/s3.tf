resource "aws_s3_bucket" "football-data-s3-adam-maas-1220" {
  bucket = "football-data-s3-adam-maas-1220"  # Change to your desired bucket name
}

resource "aws_s3_bucket_public_access_block" "football-data-s3-adam-maas-1220_public_access" {
  bucket = aws_s3_bucket.football-data-s3-adam-maas-1220.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}