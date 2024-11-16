# wizardai_aws_s3_bucket/main.tf

resource "aws_s3_bucket" "wizardai_s3_bucket" {
    bucket = var.bucket_name
    bucket_prefix = "wizardai-"
    tags = {
        Environment = var.environment
    }
}

resource "aws_s3_bucket_acl" "wizardai_s3_bucket_acl" {
  bucket = aws_s3_bucket.wizardai_s3_bucket.id
  acl    = "private"
}

resource "aws_config_config_rule" "wizardai_s3_encrypt_at_rest" {
  name        = "s3-encryption-at-rest"
  description = "Ensure that all S3 buckets have server-side encryption enabled"
  scope {
    compliance_resource_types = ["AWS::S3::Bucket"]
  }
  source {
    owner             = "AWS"
    source_identifier = "S3_BUCKET_SERVER_SIDE_ENCRYPTION_ENABLED"
  }

  # Enforce compliance for all S3 buckets
  input_parameters = jsonencode({
    "s3BucketEncryption" = "true"
  })
}

resource "aws_s3_bucket_policy" "wizardai_s3_bucket_policy" {
  bucket = aws_s3_bucket.wizardai_s3_bucket.id
  policy = data.aws_iam_policy_document.wizardai_s3_enforce_https
}

data "aws_iam_policy_document" "wizardai_s3_encrypt_in_transit" {
  statement {
    sid = "EnforceSSLRequests"
    effect = "Deny"
    actions = ["s3:*"]
    resources = [
      aws_s3_bucket.s3_bucket.arn,
      "${aws_s3_bucket.s3_bucket.arn}/*",
    ]
    condition {
      test = "Bool"
      variable = "aws:SecureTransport"
      values = ["false"]
    }
  }
}

locals {
    bucket_name = "wizardai_s3_bucket-${var.environment}"
}