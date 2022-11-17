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
| [aws_accessanalyzer_analyzer.analyzer](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/accessanalyzer_analyzer) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_analyzer_name"></a> [analyzer\_name](#input\_analyzer\_name) | The name for the IAM Access Analyzer resource to be created | `string` | `"default-analyzer"` | no |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | Whether this module is enabled or not | `bool` | `false` | no |
| <a name="input_is_org"></a> [is\_org](#input\_is\_org) | Whether this analyzer is configured for an org account or an individual account | `bool` | `false` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Specifies additional tag keys and values | `map(string)` | <pre>{<br>  "Terraform": true<br>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_analyzer_arn"></a> [analyzer\_arn](#output\_analyzer\_arn) | Analyzer ARN |
| <a name="output_analyzer_id"></a> [analyzer\_id](#output\_analyzer\_id) | Analyzer ID |
