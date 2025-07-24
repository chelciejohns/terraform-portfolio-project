provider "aws" {
  region = "eu-west-2"
}

#S3Bucket
resource "aws_s3_bucket" "nextjs-bucket" {
    bucket = "nextjs-portfolio-bucket-chelcie"
}

#owenershipcontrols
resource "aws_s3_bucket_ownership_controls" "nextjs-bucket-ownership-controls" {
  bucket = aws_s3_bucket.nextjs-bucket.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

#S3bucketPublicaccessBlock
resource "aws_s3_bucket_public_access_block" "nextjs-bucket-public-access-block" {
  bucket = aws_s3_bucket.nextjs-bucket.id
    block_public_acls       = false
    block_public_policy     = false
    ignore_public_acls      = false
    restrict_public_buckets = false
}

#BucketACL
resource "aws_s3_bucket_acl" "nextjs-bucket-acl" {
  bucket = aws_s3_bucket.nextjs-bucket.id
  acl    = "public-read"

  depends_on = [
    aws_s3_bucket_public_access_block.nextjs-bucket-public-access-block
    aws_s3_bucket_ownership_controls.nextjs-bucket-ownership-controls
    ]
}

#S3Bucketpolicy
resource "aws_s3_bucket_policy" "nextjs-bucket-policy" {
  bucket = aws_s3_bucket.nextjs-bucket.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid = "PublicReadGetObject"
        Effect = "Allow"
        Principal = "*"
        Action = "s3:GetObject"
        Resource = "${aws_s3_bucket.nextjs-bucket.arn}/*"
      }
    ]
  })}

  