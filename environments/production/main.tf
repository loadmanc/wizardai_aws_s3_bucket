# environments/production/main.tf

module "wizardai_aws_s3_bucket" {
    source = "../../"
    environment = "production"
}
