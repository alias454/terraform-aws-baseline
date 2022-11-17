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
| [aws_s3_bucket.s3bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_acl.s3bucket_acl](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_acl) | resource |
| [aws_s3_bucket_lifecycle_configuration.s3bucket_lifecycle](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_lifecycle_configuration) | resource |
| [aws_s3_bucket_policy.s3bucket_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_policy) | resource |
| [aws_s3_bucket_public_access_block.s3bucket_public_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block) | resource |
| [aws_s3_bucket_server_side_encryption_configuration.s3bucket_encryption](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_server_side_encryption_configuration) | resource |
| [aws_s3_bucket_versioning.s3bucket_versioning](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_versioning) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_block_public_acls"></a> [block\_public\_acls](#input\_block\_public\_acls) | Public block acls setting to enable blocking | `bool` | `true` | no |
| <a name="input_block_public_policy"></a> [block\_public\_policy](#input\_block\_public\_policy) | Public block policy setting to enable blocking | `bool` | `true` | no |
| <a name="input_bucket_acl"></a> [bucket\_acl](#input\_bucket\_acl) | Bucket acl can be private or public | `string` | `"private"` | no |
| <a name="input_bucket_name"></a> [bucket\_name](#input\_bucket\_name) | Bucket name to be created | `string` | `null` | no |
| <a name="input_enable_bucket_versioning"></a> [enable\_bucket\_versioning](#input\_enable\_bucket\_versioning) | Enable bucket versioning | `string` | `"Disabled"` | no |
| <a name="input_enable_lifecycle_rules"></a> [enable\_lifecycle\_rules](#input\_enable\_lifecycle\_rules) | Enable bucket lifecycle rules | `string` | `"Enabled"` | no |
| <a name="input_enable_s3_policy"></a> [enable\_s3\_policy](#input\_enable\_s3\_policy) | Attach S3 bucket policy | `bool` | `false` | no |
| <a name="input_expire_noncurrent_versions_in_days"></a> [expire\_noncurrent\_versions\_in\_days](#input\_expire\_noncurrent\_versions\_in\_days) | Expiration in days for non-current file versions | `number` | `90` | no |
| <a name="input_ignore_public_acls"></a> [ignore\_public\_acls](#input\_ignore\_public\_acls) | Ignore public acls setting to enable blocking | `bool` | `true` | no |
| <a name="input_lifecycle_expiration"></a> [lifecycle\_expiration](#input\_lifecycle\_expiration) | Days to keep data before purging | `number` | `365` | no |
| <a name="input_lifecycle_move_to_glacier"></a> [lifecycle\_move\_to\_glacier](#input\_lifecycle\_move\_to\_glacier) | Days until data migrates to GLACIER storage class | `number` | `90` | no |
| <a name="input_lifecycle_move_to_standard_ia"></a> [lifecycle\_move\_to\_standard\_ia](#input\_lifecycle\_move\_to\_standard\_ia) | Days until data migrates to STANDARD\_IA storage class | `number` | `30` | no |
| <a name="input_restrict_public_buckets"></a> [restrict\_public\_buckets](#input\_restrict\_public\_buckets) | Restrict public buckets setting to enable blocking | `bool` | `true` | no |
| <a name="input_s3_bucket_policy"></a> [s3\_bucket\_policy](#input\_s3\_bucket\_policy) | Policy that is attached to an S3 bucket | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Specifies additional tag keys and values | `map(string)` | <pre>{<br>  "Terraform": true<br>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_s3_bucket_arn"></a> [s3\_bucket\_arn](#output\_s3\_bucket\_arn) | S3 Bucket ARN |
| <a name="output_s3_bucket_id"></a> [s3\_bucket\_id](#output\_s3\_bucket\_id) | S3 Bucket ID |
| <a name="output_s3_bucket_name"></a> [s3\_bucket\_name](#output\_s3\_bucket\_name) | S3 Bucket Name |
