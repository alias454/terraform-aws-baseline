# https://docs.aws.amazon.com/IAM/latest/UserGuide/what-is-access-analyzer.html
resource "aws_accessanalyzer_analyzer" "analyzer" {
  count = var.enabled ? 1 : 0

  # If part of an org structure make sure org resource exists
  # depends_on = [aws_organizations_organization.root_account]

  analyzer_name = var.analyzer_name
  type          = var.is_org ? "ORGANIZATION" : "ACCOUNT"

  tags = merge(
    var.tags,
    {
      Name = var.analyzer_name
    }
  )
}
