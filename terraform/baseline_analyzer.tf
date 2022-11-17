# --------------------------------------------------------------------------------------------------
# Access Analyzer Baseline
# Needs to be setup in each active region
# --------------------------------------------------------------------------------------------------

# US East (N. Virginia) - us-east-1
module "baseline_analyzer_us-east-1" {
  source = "./modules/aws_access_analyzer"
  providers = {
    aws = aws.us-east-1
  }

  enabled = local.enable_analyzer && contains(var.target_regions, "us-east-1")
  is_org  = local.use_org_account

  tags = var.tags
}

# US East (Ohio) - us-east-2
module "baseline_analyzer_us-east-2" {
  source = "./modules/aws_access_analyzer"
  providers = {
    aws = aws.us-east-2
  }

  enabled = local.enable_analyzer && contains(var.target_regions, "us-east-2")
  is_org  = local.use_org_account

  tags = var.tags
}

# US West (N. California) - us-west-1
module "baseline_analyzer_us-west-1" {
  source = "./modules/aws_access_analyzer"
  providers = {
    aws = aws.us-west-1
  }

  enabled = local.enable_analyzer && contains(var.target_regions, "us-west-1")
  is_org  = local.use_org_account

  tags = var.tags
}

# US West (Oregon) - us-west-2
module "baseline_analyzer_us-west-2" {
  source = "./modules/aws_access_analyzer"
  providers = {
    aws = aws.us-west-2
  }

  enabled = local.enable_analyzer && contains(var.target_regions, "us-west-2")
  is_org  = local.use_org_account

  tags = var.tags
}

# Asia Pacific (Tokyo) - ap-northeast-1
module "baseline_analyzer_ap-northeast-1" {
  source = "./modules/aws_access_analyzer"
  providers = {
    aws = aws.ap-northeast-1
  }

  enabled = local.enable_analyzer && contains(var.target_regions, "ap-northeast-1")
  is_org  = local.use_org_account

  tags = var.tags
}

# Asia Pacific (Seoul) - ap-northeast-2
module "baseline_analyzer_ap-northeast-2" {
  source = "./modules/aws_access_analyzer"
  providers = {
    aws = aws.ap-northeast-2
  }

  enabled = local.enable_analyzer && contains(var.target_regions, "ap-northeast-2")
  is_org  = local.use_org_account

  tags = var.tags
}

# Asia Pacific (Osaka-Local) - ap-northeast-3
module "baseline_analyzer_ap-northeast-3" {
  source = "./modules/aws_access_analyzer"
  providers = {
    aws = aws.ap-northeast-3
  }

  enabled = local.enable_analyzer && contains(var.target_regions, "ap-northeast-3")
  is_org  = local.use_org_account

  tags = var.tags
}

# Asia Pacific (Mumbai) - ap-south-1
module "baseline_analyzer_ap-south-1" {
  source = "./modules/aws_access_analyzer"
  providers = {
    aws = aws.ap-south-1
  }

  enabled = local.enable_analyzer && contains(var.target_regions, "ap-south-1")
  is_org  = local.use_org_account

  tags = var.tags
}

# Asia Pacific (Singapore) - ap-southeast-1
module "baseline_analyzer_ap-southeast-1" {
  source = "./modules/aws_access_analyzer"
  providers = {
    aws = aws.ap-southeast-1
  }

  enabled = local.enable_analyzer && contains(var.target_regions, "ap-southeast-1")
  is_org  = local.use_org_account

  tags = var.tags
}

# Asia Pacific (Sydney) - ap-southeast-2
module "baseline_analyzer_ap-southeast-2" {
  source = "./modules/aws_access_analyzer"
  providers = {
    aws = aws.ap-southeast-2
  }

  enabled = local.enable_analyzer && contains(var.target_regions, "ap-southeast-2")
  is_org  = local.use_org_account

  tags = var.tags
}

# Canada (Central) - ca-central-1
module "baseline_analyzer_ca-central-1" {
  source = "./modules/aws_access_analyzer"
  providers = {
    aws = aws.ca-central-1
  }

  enabled = local.enable_analyzer && contains(var.target_regions, "ca-central-1")
  is_org  = local.use_org_account

  tags = var.tags
}

# EU (Frankfurt) - eu-central-1
module "baseline_analyzer_eu-central-1" {
  source = "./modules/aws_access_analyzer"
  providers = {
    aws = aws.eu-central-1
  }

  enabled = local.enable_analyzer && contains(var.target_regions, "eu-central-1")
  is_org  = local.use_org_account

  tags = var.tags
}

# EU (Stockholm) - eu-north-1
module "baseline_analyzer_eu-north-1" {
  source = "./modules/aws_access_analyzer"
  providers = {
    aws = aws.eu-north-1
  }

  enabled = local.enable_analyzer && contains(var.target_regions, "eu-north-1")
  is_org  = local.use_org_account

  tags = var.tags
}

# EU (Ireland) - eu-west-1
module "baseline_analyzer_eu-west-1" {
  source = "./modules/aws_access_analyzer"
  providers = {
    aws = aws.eu-west-1
  }

  enabled = local.enable_analyzer && contains(var.target_regions, "eu-west-1")
  is_org  = local.use_org_account

  tags = var.tags
}

# EU (London) - eu-west-2
module "baseline_analyzer_eu-west-2" {
  source = "./modules/aws_access_analyzer"
  providers = {
    aws = aws.eu-west-2
  }

  enabled = local.enable_analyzer && contains(var.target_regions, "eu-west-2")
  is_org  = local.use_org_account

  tags = var.tags
}

# EU (Paris) - eu-west-3
module "baseline_analyzer_eu-west-3" {
  source = "./modules/aws_access_analyzer"
  providers = {
    aws = aws.eu-west-3
  }

  enabled = local.enable_analyzer && contains(var.target_regions, "eu-west-3")
  is_org  = local.use_org_account

  tags = var.tags
}

# South America (Sao Paulo) - sa-east-1
module "baseline_analyzer_sa-east-1" {
  source = "./modules/aws_access_analyzer"
  providers = {
    aws = aws.sa-east-1
  }

  enabled = local.enable_analyzer && contains(var.target_regions, "sa-east-1")
  is_org  = local.use_org_account

  tags = var.tags
}
