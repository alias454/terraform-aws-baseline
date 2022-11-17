# --------------------------------------------------------------------------------------------------
# AWS Config Baseline
# --------------------------------------------------------------------------------------------------

# Setup required S3 bucket for data storage
module "config_s3bucket_module" {
  source = "./modules/aws_s3_bucket"

  providers = {
    aws = aws.us-east-1
  }

  bucket_name = local.config_s3_bucket_name

  enable_s3_policy         = true
  enable_bucket_versioning = "Enabled"
  s3_bucket_policy         = data.aws_iam_policy_document.config_s3bucket_policy.json

  tags = var.tags
}

# Create IAM Role for AWS Config recorder
module "iam_config_role_module" {
  source = "./modules/aws_iam_role"

  providers = {
    aws = aws.us-east-1
  }

  iam_name           = "ConfigServiceRecorder"
  description        = "Allow access from Config service"
  assume_role_policy = data.aws_iam_policy_document.recorder_assume_role_policy.json
  app_policy_data    = data.aws_iam_policy_document.recorder_publish_role_policy.json

  allow_aws_managed  = true
  managed_policy_arn = "arn:aws:iam::aws:policy/service-role/AWS_ConfigRole"

  tags = var.tags
}

# AWS Config needs to be setup in each active region

# US East (N. Virginia) - us-east-1
module "baseline_config_us-east-1" {
  source = "./modules/baseline_config"

  providers = {
    aws = aws.us-east-1
  }

  enabled        = local.enable_config && contains(var.target_regions, "us-east-1")
  iam_role_arn   = module.iam_config_role_module.iam_role_arn
  s3_bucket_name = local.config_s3_bucket_name

  sns_enabled = local.enable_config_sns # defaults to false

  tags = var.tags

  depends_on = [
    module.config_s3bucket_module
  ]
}

# US East (Ohio) - us-east-2
module "baseline_config_us-east-2" {
  source = "./modules/baseline_config"

  providers = {
    aws = aws.us-east-2
  }

  enabled        = local.enable_config && contains(var.target_regions, "us-east-2")
  iam_role_arn   = module.iam_config_role_module.iam_role_arn
  s3_bucket_name = local.config_s3_bucket_name

  sns_enabled = local.enable_config_sns # defaults to false

  tags = var.tags

  depends_on = [
    module.config_s3bucket_module
  ]
}

# US West (N. California) - us-west-1
module "baseline_config_us-west-1" {
  source = "./modules/baseline_config"

  providers = {
    aws = aws.us-west-1
  }

  enabled        = local.enable_config && contains(var.target_regions, "us-west-1")
  iam_role_arn   = module.iam_config_role_module.iam_role_arn
  s3_bucket_name = local.config_s3_bucket_name

  sns_enabled = local.enable_config_sns # defaults to false

  tags = var.tags

  depends_on = [
    module.config_s3bucket_module
  ]
}

# US West (Oregon) - us-west-2
module "baseline_config_us-west-2" {
  source = "./modules/baseline_config"

  providers = {
    aws = aws.us-west-2
  }

  enabled        = local.enable_config && contains(var.target_regions, "us-west-2")
  iam_role_arn   = module.iam_config_role_module.iam_role_arn
  s3_bucket_name = local.config_s3_bucket_name

  sns_enabled = local.enable_config_sns # defaults to false

  tags = var.tags

  depends_on = [
    module.config_s3bucket_module
  ]
}

# Asia Pacific (Tokyo) - ap-northeast-1
module "baseline_config_ap-northeast-1" {
  source = "./modules/baseline_config"

  providers = {
    aws = aws.ap-northeast-1
  }

  enabled        = local.enable_config && contains(var.target_regions, "ap-northeast-1")
  iam_role_arn   = module.iam_config_role_module.iam_role_arn
  s3_bucket_name = local.config_s3_bucket_name

  sns_enabled = local.enable_config_sns # defaults to false

  tags = var.tags

  depends_on = [
    module.config_s3bucket_module
  ]
}

# Asia Pacific (Seoul) - ap-northeast-2
module "baseline_config_ap-northeast-2" {
  source = "./modules/baseline_config"

  providers = {
    aws = aws.ap-northeast-2
  }

  enabled        = local.enable_config && contains(var.target_regions, "ap-northeast-2")
  iam_role_arn   = module.iam_config_role_module.iam_role_arn
  s3_bucket_name = local.config_s3_bucket_name

  sns_enabled = local.enable_config_sns # defaults to false

  tags = var.tags

  depends_on = [
    module.config_s3bucket_module
  ]
}

# Asia Pacific (Osaka-Local) - ap-northeast-3
module "baseline_config_ap-northeast-3" {
  source = "./modules/baseline_config"

  providers = {
    aws = aws.ap-northeast-3
  }

  enabled        = local.enable_config && contains(var.target_regions, "ap-northeast-3")
  iam_role_arn   = module.iam_config_role_module.iam_role_arn
  s3_bucket_name = local.config_s3_bucket_name

  sns_enabled = local.enable_config_sns # defaults to false

  tags = var.tags

  depends_on = [
    module.config_s3bucket_module
  ]
}

# Asia Pacific (Mumbai) - ap-south-1
module "baseline_config_ap-south-1" {
  source = "./modules/baseline_config"

  providers = {
    aws = aws.ap-south-1
  }

  enabled        = local.enable_config && contains(var.target_regions, "ap-south-1")
  iam_role_arn   = module.iam_config_role_module.iam_role_arn
  s3_bucket_name = local.config_s3_bucket_name

  sns_enabled = local.enable_config_sns # defaults to false

  tags = var.tags

  depends_on = [
    module.config_s3bucket_module
  ]
}

# Asia Pacific (Singapore) - ap-southeast-1
module "baseline_config_ap-southeast-1" {
  source = "./modules/baseline_config"

  providers = {
    aws = aws.ap-southeast-1
  }

  enabled        = local.enable_config && contains(var.target_regions, "ap-southeast-1")
  iam_role_arn   = module.iam_config_role_module.iam_role_arn
  s3_bucket_name = local.config_s3_bucket_name

  sns_enabled = local.enable_config_sns # defaults to false

  tags = var.tags

  depends_on = [
    module.config_s3bucket_module
  ]
}

# Asia Pacific (Sydney) - ap-southeast-2
module "baseline_config_ap-southeast-2" {
  source = "./modules/baseline_config"

  providers = {
    aws = aws.ap-southeast-2
  }

  enabled        = local.enable_config && contains(var.target_regions, "ap-southeast-2")
  iam_role_arn   = module.iam_config_role_module.iam_role_arn
  s3_bucket_name = local.config_s3_bucket_name

  sns_enabled = local.enable_config_sns # defaults to false

  tags = var.tags

  depends_on = [
    module.config_s3bucket_module
  ]
}

# Canada (Central) - ca-central-1
module "baseline_config_ca-central-1" {
  source = "./modules/baseline_config"

  providers = {
    aws = aws.ca-central-1
  }

  enabled        = local.enable_config && contains(var.target_regions, "ca-central-1")
  iam_role_arn   = module.iam_config_role_module.iam_role_arn
  s3_bucket_name = local.config_s3_bucket_name

  sns_enabled = local.enable_config_sns # defaults to false

  tags = var.tags
}

# EU (Frankfurt) - eu-central-1
module "baseline_config_eu-central-1" {
  source = "./modules/baseline_config"

  providers = {
    aws = aws.eu-central-1
  }

  enabled        = local.enable_config && contains(var.target_regions, "eu-central-1")
  iam_role_arn   = module.iam_config_role_module.iam_role_arn
  s3_bucket_name = local.config_s3_bucket_name

  sns_enabled = local.enable_config_sns # defaults to false

  tags = var.tags

  depends_on = [
    module.config_s3bucket_module
  ]
}

# EU (Stockholm) - eu-north-1
module "baseline_config_eu-north-1" {
  source = "./modules/baseline_config"

  providers = {
    aws = aws.eu-north-1
  }

  enabled        = local.enable_config && contains(var.target_regions, "eu-north-1")
  iam_role_arn   = module.iam_config_role_module.iam_role_arn
  s3_bucket_name = local.config_s3_bucket_name

  sns_enabled = local.enable_config_sns # defaults to false

  tags = var.tags

  depends_on = [
    module.config_s3bucket_module
  ]
}

# EU (Ireland) - eu-west-1
module "baseline_config_eu-west-1" {
  source = "./modules/baseline_config"

  providers = {
    aws = aws.eu-west-1
  }

  enabled        = local.enable_config && contains(var.target_regions, "eu-west-1")
  iam_role_arn   = module.iam_config_role_module.iam_role_arn
  s3_bucket_name = local.config_s3_bucket_name

  sns_enabled = local.enable_config_sns # defaults to false

  tags = var.tags

  depends_on = [
    module.config_s3bucket_module
  ]
}

# EU (London) - eu-west-2
module "baseline_config_eu-west-2" {
  source = "./modules/baseline_config"

  providers = {
    aws = aws.eu-west-2
  }

  enabled        = local.enable_config && contains(var.target_regions, "eu-west-2")
  iam_role_arn   = module.iam_config_role_module.iam_role_arn
  s3_bucket_name = local.config_s3_bucket_name

  sns_enabled = local.enable_config_sns # defaults to false

  tags = var.tags

  depends_on = [
    module.config_s3bucket_module
  ]
}

# EU (Paris) - eu-west-3
module "baseline_config_eu-west-3" {
  source = "./modules/baseline_config"

  providers = {
    aws = aws.eu-west-3
  }

  enabled        = local.enable_config && contains(var.target_regions, "eu-west-3")
  iam_role_arn   = module.iam_config_role_module.iam_role_arn
  s3_bucket_name = local.config_s3_bucket_name

  sns_enabled = local.enable_config_sns # defaults to false

  tags = var.tags

  depends_on = [
    module.config_s3bucket_module
  ]
}

# South America (Sao Paulo) - sa-east-1
module "baseline_config_sa-east-1" {
  source = "./modules/baseline_config"

  providers = {
    aws = aws.sa-east-1
  }

  enabled        = local.enable_config && contains(var.target_regions, "sa-east-1")
  iam_role_arn   = module.iam_config_role_module.iam_role_arn
  s3_bucket_name = local.config_s3_bucket_name

  sns_enabled = local.enable_config_sns # defaults to false

  tags = var.tags

  depends_on = [
    module.config_s3bucket_module
  ]
}
