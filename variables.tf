# wizardai_aws_s3_bucket/variables.tf

variable "bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
}

variable "environment" {
  description = "The environment (development, staging, production)"
  type        = string
}


