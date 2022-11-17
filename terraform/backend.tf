 terraform {
  backend "local" {
    path = "terraform.tfstate"
  }
 }

# Optionally, create a S3 bucket to store the Terraform state in
# aws s3 mb s3://<bucket-prefix>-<project-name>-tfstate
#
# aws s3api put-bucket-versioning \
# --bucket <bucket-prefix>-<project-name>-tfstate \
# --versioning-configuration "Status=Enabled"
#
# aws s3api put-public-access-block \
# --bucket <bucket-prefix>-<project-name>-tfstate \
# --public-access-block-configuration "BlockPublicAcls=true,IgnorePublicAcls=true,BlockPublicPolicy=true,RestrictPublicBuckets=true"
#
# Optionally, add a DynamoDB table for locking
# aws dynamodb create-table \
# --table-name <project-name>-tfstate \
# --attribute-definitions AttributeName=LockID,AttributeType=S \
# --key-schema AttributeName=LockID,KeyType=HASH \
# --provisioned-throughput ReadCapacityUnits=5,WriteCapacityUnits=5
#
# terraform init -migrate-state
#
# terraform {
#   backend "s3" {
#     bucket         = "<bucket-prefix>-<project-name>-tfstate"
#     dynamodb_table = "<project-name>-state"
#     key            = "<project-name>/terraform.tfstate"
#     region         = "us-east-1"
#     encrypt        = true
#   }
# }
#
# It may be beneficial if running this against multiple accounts to use a partial configuration
# https://developer.hashicorp.com/terraform/language/settings/backends/configuration#partial-configuration
#
# terraform init -backend-config="bucket=<bucket-prefix>-<project-name>-tfstate"
#
#terraform {
#  backend "s3" {
#    # Pass in bucket and key using terraform init
#    key     = "aws-baseline/terraform.tfstate"
#    region  = "us-east-1"
#    encrypt = true
#  }
#}
