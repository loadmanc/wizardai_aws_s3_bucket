# wizardai_aws_s3_bucket/outputs.tf

output "s3_bucket_id" {
  description = "The name of the S3 bucket."
  value       = try(aws_s3_bucket_policy.wizardai_s3_bucket_policy.id, aws_s3_bucket.wizardai_s3_bucket.id, "")
}

output "s3_bucket_arn" {
  description = "The ARN of the S3 bucket. It will be of the format arn:aws:s3:::bucketname."
  value       = try(aws_s3_bucket.wizardai_s3_bucket.arn, "")
}

output "s3_bucket_bucket_domain_name" {
  description = "The bucket domain name. Will be of format bucketname.s3.amazonaws.com."
  value       = try(aws_s3_bucket.wizardai_s3_bucket.bucket_domain_name, "")
}

output "s3_bucket_bucket_regional_domain_name" {
  description = "The bucket region-specific domain name. The bucket domain name including the region name, please refer here for format. Note: The AWS CloudFront allows specifying S3 region-specific endpoint when creating S3 origin, it will prevent redirect issues from CloudFront to S3 Origin URL."
  value       = try(aws_s3_bucket.wizardai_s3_bucket.bucket_regional_domain_name, "")
}

output "s3_bucket_hosted_zone_id" {
  description = "The Route 53 Hosted Zone ID for this bucket's region."
  value       = try(aws_s3_bucket.wizardai_s3_bucket.hosted_zone_id, "")
}

output "s3_bucket_policy" {
  description = "The policy of the bucket, if the bucket is configured with a policy. If not, this will be an empty string."
  value       = try(aws_s3_bucket_policy.wizardai_s3_bucket_policy.policy, "")
}

output "s3_bucket_region" {
  description = "The AWS region this bucket resides in."
  value       = try(aws_s3_bucket.wizardai_s3_bucket.region, "")
}
