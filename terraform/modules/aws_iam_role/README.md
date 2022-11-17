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
| [aws_iam_role.iam_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.app_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy_attachment.app_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allow_aws_managed"></a> [allow\_aws\_managed](#input\_allow\_aws\_managed) | Allow adding a managed policy | `bool` | `false` | no |
| <a name="input_app_policy_data"></a> [app\_policy\_data](#input\_app\_policy\_data) | AWS IAM policy JSON data | `string` | `null` | no |
| <a name="input_assume_role_policy"></a> [assume\_role\_policy](#input\_assume\_role\_policy) | JSON data for sts assume role | `string` | `null` | no |
| <a name="input_create"></a> [create](#input\_create) | Create IAM role if true | `bool` | `true` | no |
| <a name="input_description"></a> [description](#input\_description) | Description of the IAM role | `string` | `null` | no |
| <a name="input_iam_name"></a> [iam\_name](#input\_iam\_name) | Name of the IAM role to create | `string` | `null` | no |
| <a name="input_managed_policy_arn"></a> [managed\_policy\_arn](#input\_managed\_policy\_arn) | ARN of the managed policy to add | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Specifies additional tag keys and values | `map(string)` | <pre>{<br>  "Terraform": true<br>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_iam_role_arn"></a> [iam\_role\_arn](#output\_iam\_role\_arn) | IAM Role ARN |
