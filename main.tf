resource "aws_s3_bucket" "s3_bucket" {
  bucket = "JENKINS-CSV-UPLOAD-10-08"
  acl    = "private"
  tags = {
    Name        = "JENKINS-CSV-UPLOAD-10-08"
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
      "Action": [
        "s3:GetObject",
        "s3:PutObject",
        "s3:PutObjectAcl",
        "s3.DeleteObject",
        "s3:ListBucket",
        "s3.DeleteBucket"
      ],
      "Resource": [
        "arn:aws:s3:::JENKINS-CSV-UPLOAD-10-08/*"
      ]
    }
  ]
}
POLICY
}
