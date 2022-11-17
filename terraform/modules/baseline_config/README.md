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
| [aws_config_configuration_recorder.recorder_config](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/config_configuration_recorder) | resource |
| [aws_config_configuration_recorder_status.recorder_status](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/config_configuration_recorder_status) | resource |
| [aws_config_delivery_channel.recorder_delivery_channel](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/config_delivery_channel) | resource |
| [aws_sns_topic.sns_topic](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_delivery_channel_name"></a> [delivery\_channel\_name](#input\_delivery\_channel\_name) | Name of the delivery channel | `string` | `"default"` | no |
| <a name="input_delivery_frequency"></a> [delivery\_frequency](#input\_delivery\_frequency) | Frequency which AWS Config sends a snapshot into the S3 bucket | `string` | `"One_Hour"` | no |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | Whether this module is enabled or not | `bool` | `false` | no |
| <a name="input_iam_role_arn"></a> [iam\_role\_arn](#input\_iam\_role\_arn) | The ARN of the IAM Role which AWS Config will use | `string` | `null` | no |
| <a name="input_include_global_resource_types"></a> [include\_global\_resource\_types](#input\_include\_global\_resource\_types) | Specifies whether AWS Config includes all supported global resource types that it records | `bool` | `true` | no |
| <a name="input_kms_key_id"></a> [kms\_key\_id](#input\_kms\_key\_id) | Data encryption key (DEK) responsible for encrypting the contents of Amazon SNS messages | `string` | `"alias/aws/sns"` | no |
| <a name="input_recorder_name"></a> [recorder\_name](#input\_recorder\_name) | Name of the configuration recorder | `string` | `"default"` | no |
| <a name="input_s3_bucket_name"></a> [s3\_bucket\_name](#input\_s3\_bucket\_name) | S3 bucket to store configuration snapshots in | `string` | `null` | no |
| <a name="input_s3_key_prefix"></a> [s3\_key\_prefix](#input\_s3\_key\_prefix) | The prefix for the specified S3 bucket | `string` | `""` | no |
| <a name="input_sns_enabled"></a> [sns\_enabled](#input\_sns\_enabled) | Whether to use SNS topics or not. If true, sns\_topic\_name should be passed in | `bool` | `false` | no |
| <a name="input_sns_topic_name"></a> [sns\_topic\_name](#input\_sns\_topic\_name) | The name of the SNS Topic to be used to notify configuration changes | `string` | `"config-topic"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Specifies additional tag keys and values | `map(string)` | <pre>{<br>  "Terraform": true<br>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_config_sns_topic_name"></a> [config\_sns\_topic\_name](#output\_config\_sns\_topic\_name) | SNS topic name that AWS Config delivers notifications to |
| <a name="output_configuration_recorder"></a> [configuration\_recorder](#output\_configuration\_recorder) | The configuration recorder |
