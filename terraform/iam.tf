resource "aws_iam_user" "example_user" {
  name = "example-user"
}

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
#Lambda function for TF
# Create an IAM role for the Lambda function
resource "aws_iam_role" "lambda_role" {
  name = "lambda_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "lambda.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })
}

# Attach the basic execution policy to the role
resource "aws_iam_role_policy_attachment" "lambda_policy_attachment" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}