resource "aws_s3_bucket" "football-data-s3-adam-maas-12202" {
  bucket = "football-data-s3-adam-maas-12202"  # Change to your desired bucket name
}

resource "aws_s3_bucket_public_access_block" "football-data-s3-adam-maas-12202_public_access" {
  bucket = aws_s3_bucket.football-data-s3-adam-maas-12202.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

//Add in the java executable jar file to the s3 bucket
# resource "aws_s3_object" "lambda_jar" {
#   bucket = aws_s3_bucket.football-data-s3-adam-maas-12202.bucket
#   key    = "APIData-0.0.1-SNAPSHOT.jar"
#   source = "/Users/adammaas/Desktop/GitHub_Repositories/s3_data_landing/save_file_to_s3_springboot_app/target/APIData-0.0.1-SNAPSHOT.jar"
# }



//IAM Roles associated with the sd3 bucket resource "aws_iam_policy" "s3_bucket_creation_policy" {
resource "aws_iam_policy" "s3_bucket_creation_policy" {
  name        = "S3BucketCreationPolicy"
  description = "Policy to allow creating S3 buckets"
  policy      = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = [
          "s3:CreateBucket",
          "s3:PutBucketAcl",
          "s3:PutBucketPolicy",
          "s3:PutBucketLogging",
          "s3:PutBucketNotification",
          "s3:PutBucketTagging",
          "s3:PutBucketVersioning",
          "s3:PutBucketWebsite"
        ]
        Resource = "arn:aws:s3:::*"
      }
    ]
  })
}

resource "aws_iam_user_policy_attachment" "example_user_attach_policy" {
  user       = aws_iam_user.example_user.name
  policy_arn = aws_iam_policy.s3_bucket_creation_policy.arn
}

resource "aws_iam_user_policy_attachment" "example_user_attach_s3_full_access" {
  user       = aws_iam_user.example_user.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}
