# wizardai_aws_s3_bucket/main.tf

provider "aws" {
  region = "ap-southeast-2"
}

resource "aws_s3_bucket" "wizardai_s3_bucket" {
  bucket = "${local.bucket_prefix}-${local.bucket_name}-${var.environment}"
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

resource "random_string" "random_value" {
  length  = 16
  special = false
  upper   = false
  lower   = true
  numeric  = true

  keepers = {
    value = var.bucket != "null" ? var.bucket : "default"
  }
}

locals {
  bucket_prefix = "wizardai"
  bucket_name = var.bucket != "null" ? var.bucket : random_string.random_value.result
}