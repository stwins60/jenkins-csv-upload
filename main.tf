resource "aws_s3_bucket" "s3_bucket" {
  bucket = "vivians3bucket1007"
  acl    = "private"
  tags = {
    Name        = "vivians3bucket1007"
    Environment = "dev"
  }
}

resource "aws_s3_bucket_policy" "s3_bucket_policy" {
  bucket = aws_s3_bucket.s3_bucket.id
  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "PublicReadGetObject",
      "Effect": "Allow",
      "Principal": "*",
      "Action": "s3:*",
      "Resource": "arn:aws:s3:::vivians3bucket1007/*"
      
    }
  ]
}
POLICY
}
