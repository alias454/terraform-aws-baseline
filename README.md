# AWS Terraform Baseline

Configure baseline AWS account settings and create necessary resources for secure account provisioning.

<!-- TOC -->
- [Environment](#Environment)
- [Getting Started](#Getting-Started)
- [Maintaining this repo](#Maintaining-this-repo)
- [Additional Resources](#Additional-Resources)
<!-- /TOC -->

## Environment
Manage baseline configs for AWS, which include the following:
- Enable IAM Access Analyzer across all active regions
- Set up AWS Config to enable continuous monitoring of AWS resources
  - Creates a versioned s3 bucket to store AWS Config data
  - IAM role allowing Config service to store AWS Config data in s3
  - Sets up AWS Config recorders per region within an account
  - (Optional) SNS Topic management for AWS Config Notifications
- Configure Cloudtrails to send data to a CloudWatch log group
  - Create an S3 bucket for storing Cloudtrails event data
  - IAM role for Cloudtrails to CloudWatch event delivery
  - KMS key for securing Cloudtrails data
  - CloudWatch logs group to accept Cloudtrail events
  - (Optional) SNS Topic management for AWS Cloudtrail data

## Getting Started
- Clone this repo to somewhere on your local machine
- Optionally, create an S3 bucket to store the Terraform state in (see backend.tf)
- Run `terraform init` within the **./terraform/** directory to initialize any modules

If this is a first time setup or if deploying a new environment, change the items located in
the **locals.tf** file. The locals.tf file is located in the **./terraform/** directory and is where 
the unique settings should be stored.

### Using CircleCi with AWS
- Setup Circle CI as an OpenID IDP provider in AWS
- Create the role to be used for the project i.e. `circle_dev_access_role`
```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Federated": "arn:aws:iam::<aws_account_id>:oidc-provider/oidc.circleci.com/org/<circleci_org_id>"
            },
            "Action": "sts:AssumeRoleWithWebIdentity",
            "Condition": {
                "StringLike": {
                    "oidc.circleci.com/org/<circleci_org_id>:sub": "org/<circleci_org_id>/project/<circleci_project_id>/user/*",
                    "oidc.circleci.com/org/<circleci_org_id>:aud": "<circleci_org_id>"
                }
            }
        }
    ]
}
```
- Assign Required permissions to the role
- Use the ARN of the CircleCI role and the AWS backend bucket when setting up workflows
  - Each account should use a separate backend config
```yaml
version: 2.1

parameters:
  AWS_ROLE_ARN_DEV:
  type: string
  default: "arn:aws:iam::xxxxxxxxxxxx:role/circle_dev_access_role"
[...]
workflows:
  version: 2
  tf_deploy:
    jobs:
      # Job run for DEV account
      - tf_init:
          name: tf_init_dev
          context: << pipeline.parameters.DEFAULT_CONTEXT >>
          exec:
            name: << pipeline.parameters.DEFAULT_EXECUTOR >>
            AWS_ROLE_ARN: << pipeline.parameters.AWS_ROLE_ARN_DEV >>
            AWS_S3_BACKEND: <bucket-prefix>-<project-name>-tfstate
      - tf_plan:
          name: tf_plan_dev
          context: << pipeline.parameters.DEFAULT_CONTEXT >>
          requires:
            - tf_init_dev
          exec:
            name: << pipeline.parameters.DEFAULT_EXECUTOR >>
            AWS_ROLE_ARN: << pipeline.parameters.AWS_ROLE_ARN_DEV >>
      - tf_apply:
          name: tf_apply_dev
          context: << pipeline.parameters.DEFAULT_CONTEXT >>
          requires:
            - tf_plan_dev
          filters:
            branches:
              only: main
          exec:
            name: << pipeline.parameters.DEFAULT_EXECUTOR >>
            AWS_ROLE_ARN: << pipeline.parameters.AWS_ROLE_ARN_DEV >>
```
- Add additional roles and workflows as needed
- Create a new context for the project in the CircleCi web UI
- Enable the project once the **.circlci/config.yml** file is updated in the repo
- Go through the project setting in the WebUI and make any appropriate changes

## Maintaining this repo
The Terraform ecosystem has lots of tools designed to keep tf code readable, documented, and secure.  
Here is a list of some tools that might be helpful and can be run from time to time as changes are made.
- terraform fmt (built-in)
- terraform-docs (<https://github.com/terraform-docs/terraform-docs>)
- tfsec (<https://github.com/aquasecurity/tfsec>)

Examples:  
Run this from the root of the **terraform** directory to format tf files consistently.
```bash
terraform fmt -recursive
```

Run this from within the **./modules** directory to update the README files, if any changes were made to modules.
```bash
for dir in `ls`; do terraform-docs --hide modules markdown ${dir} > ${dir}/README.md; done
```

If any updates were done to the project dir ex. **../terraform/**, run this from inside that directory.
```bash
terraform-docs markdown . > README.md
```

## Additional Resources
- <https://circleci.com/docs/openid-connect-tokens>
- <https://registry.terraform.io/providers/hashicorp/aws/latest/docs>
- <https://docs.aws.amazon.com/IAM/latest/UserGuide/what-is-access-analyzer.html>
- <https://docs.aws.amazon.com/config/latest/developerguide/WhatIsConfig.html>
