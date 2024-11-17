# wizardai_aws_s3_bucket/variables.tf

variable "bucket" {
  description = "The name of the S3 bucket (Optional. A random name will be generated if not supplied)"
  type        = string
  default     = "null"
}

variable "environment" {
  description = "The environment (development, staging, production)"
  type        = string
}


