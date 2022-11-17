## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.14.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.0.0 |

## Resources

| Name | Type |
|------|------|
| [aws_cloudtrail.cloudtrail_trail](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudtrail) | resource |
| [aws_sns_topic.cloudtrail_sns_topic](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic) | resource |
| [aws_sns_topic_policy.local_account_cloudtrail](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic_policy) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cloud_watch_logs_group_arn"></a> [cloud\_watch\_logs\_group\_arn](#input\_cloud\_watch\_logs\_group\_arn) | Log group ARN that represents a CloudWatch log group to where CloudTrail logs will be delivered | `string` | `null` | no |
| <a name="input_cloud_watch_logs_role_arn"></a> [cloud\_watch\_logs\_role\_arn](#input\_cloud\_watch\_logs\_role\_arn) | Role ARN for the CloudWatch Logs endpoint to assume to write to a user’s log group | `string` | `null` | no |
| <a name="input_cloudtrail_name"></a> [cloudtrail\_name](#input\_cloudtrail\_name) | The name of the trail | `string` | `"cloudtrail-topic"` | no |
| <a name="input_cloudtrail_sns_policy"></a> [cloudtrail\_sns\_policy](#input\_cloudtrail\_sns\_policy) | A valid JSON key policy | `string` | `null` | no |
| <a name="input_cloudwatch_enabled"></a> [cloudwatch\_enabled](#input\_cloudwatch\_enabled) | Enable delivering the trail to CloudWatch | `bool` | `false` | no |
| <a name="input_data_resource_dynamodb_values"></a> [data\_resource\_dynamodb\_values](#input\_data\_resource\_dynamodb\_values) | List of ARN strings or partial ARN strings to specify as selectors for data resource audit events | `list(string)` | `[]` | no |
| <a name="input_data_resource_lambda_values"></a> [data\_resource\_lambda\_values](#input\_data\_resource\_lambda\_values) | List of ARN strings or partial ARN strings to specify as selectors for data resource audit events | `list(string)` | `[]` | no |
| <a name="input_data_resource_s3_values"></a> [data\_resource\_s3\_values](#input\_data\_resource\_s3\_values) | List of ARN strings or partial ARN strings to specify as selectors for data resource audit events | `list(string)` | `[]` | no |
| <a name="input_enable_log_file_validation"></a> [enable\_log\_file\_validation](#input\_enable\_log\_file\_validation) | Enable log file integrity validation. Defaults to false | `bool` | `true` | no |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | Whether this module is enabled or not | `bool` | `false` | no |
| <a name="input_include_global_service_events"></a> [include\_global\_service\_events](#input\_include\_global\_service\_events) | Whether the trail is publishing events from global services such as IAM to log files. Defaults to true | `bool` | `true` | no |
| <a name="input_is_org_trail"></a> [is\_org\_trail](#input\_is\_org\_trail) | Whether the trail is an Organizations trail, which log events for master and all member accounts | `bool` | `false` | no |
| <a name="input_kms_key_id"></a> [kms\_key\_id](#input\_kms\_key\_id) | Data encryption key (DEK) responsible for encrypting the contents of Amazon SNS messages | `string` | `"alias/aws/sns"` | no |
| <a name="input_multi_region"></a> [multi\_region](#input\_multi\_region) | Indicates if the trail is created in all regions (true) or is regional (false) defaults to false | `bool` | `true` | no |
| <a name="input_s3_bucket_name"></a> [s3\_bucket\_name](#input\_s3\_bucket\_name) | S3 bucket designated to store log files in | `string` | `null` | no |
| <a name="input_s3_key_prefix"></a> [s3\_key\_prefix](#input\_s3\_key\_prefix) | The prefix for the specified S3 bucket | `string` | `null` | no |
| <a name="input_sns_enabled"></a> [sns\_enabled](#input\_sns\_enabled) | Whether to use SNS topics or not. If true, sns\_topic\_name should be passed in | `bool` | `false` | no |
| <a name="input_sns_topic_name"></a> [sns\_topic\_name](#input\_sns\_topic\_name) | SNS topic name to be used for notification of log file delivery | `string` | `"cloudtrail-topic"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Specifies additional tag keys and values | `map(string)` | <pre>{<br>  "Terraform": true<br>}</pre> | no |

## Outputs

No outputs.
