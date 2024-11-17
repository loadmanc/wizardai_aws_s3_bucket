# wizardai_aws_s3_bucket/main.tf

provider "aws" {
  region = "ap-southeast-2"
}

resource "aws_s3_bucket" "wizardai_s3_bucket" {
  bucket = local.bucket_name
  tags = {
    Environment = var.environment
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "wizardai_s3_bucket_encryption" {
  bucket = aws_s3_bucket.wizardai_s3_bucket.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_policy" "wizardai_s3_bucket_policy" {
  bucket = aws_s3_bucket.wizardai_s3_bucket.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action    = "s3:*"
        Effect    = "Deny"
        Resource  = "${aws_s3_bucket.wizardai_s3_bucket.arn}"
        Condition = {
          Bool = {
            "aws:SecureTransport" = "false"
          }
        }
        Principal = {
          Service = "config.amazonaws.com"
        }
      }
    ]
  })
}

locals {
  bucket_name = "wizardai-s3-bucket-${var.environment}"
}