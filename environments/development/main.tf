# environments/development/main.tf

module "wizardai_aws_s3_bucket" {
    source = "../wizardai_aws_s3_bucket"
    environment = "development"
}