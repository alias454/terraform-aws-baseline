# Set terraform settings
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
  required_version = ">= 0.14.0"
}

# These regions require opt-in and are not currently configured
# Africa (Cape Town) af-south-1
# Europe (Milan) eu-south-1
# Middle East (Bahrain) me-south-1
# Middle East (UAE) me-central-1
# Asia Pacific (Hong Kong) ap-east-1
# Asia Pacific (Jakarta) ap-southeast-3

# Configure the Default AWS Provider
provider "aws" {
  region = var.region
}

# US East (N. Virginia) - us-east-1
provider "aws" {
  alias  = "us-east-1"
  region = "us-east-1"

  default_tags {
    tags = {
      RegionName = "us-east-1"
    }
  }
}

# US East (Ohio) - us-east-2
provider "aws" {
  alias  = "us-east-2"
  region = "us-east-2"

  default_tags {
    tags = {
      RegionName = "us-east-2"
    }
  }
}

# US West (N. California) - us-west-1
provider "aws" {
  alias  = "us-west-1"
  region = "us-west-1"

  default_tags {
    tags = {
      RegionName = "us-west-1"
    }
  }
}

# US West (Oregon) - us-west-2
provider "aws" {
  alias  = "us-west-2"
  region = "us-west-2"

  default_tags {
    tags = {
      RegionName = "us-west-2"
    }
  }
}

# Asia Pacific (Tokyo) - ap-northeast-1
provider "aws" {
  alias  = "ap-northeast-1"
  region = "ap-northeast-1"

  default_tags {
    tags = {
      RegionName = "ap-northeast-1"
    }
  }
}

# Asia Pacific (Seoul) - ap-northeast-2
provider "aws" {
  alias  = "ap-northeast-2"
  region = "ap-northeast-2"

  default_tags {
    tags = {
      RegionName = "ap-northeast-2"
    }
  }
}

# Asia Pacific (Osaka-Local) - ap-northeast-3
provider "aws" {
  alias  = "ap-northeast-3"
  region = "ap-northeast-3"

  default_tags {
    tags = {
      RegionName = "ap-northeast-3"
    }
  }
}

# Asia Pacific (Mumbai) - ap-south-1
provider "aws" {
  alias  = "ap-south-1"
  region = "ap-south-1"

  default_tags {
    tags = {
      RegionName = "ap-south-1"
    }
  }
}

# Asia Pacific (Singapore) - ap-southeast-1
provider "aws" {
  alias  = "ap-southeast-1"
  region = "ap-southeast-1"

  default_tags {
    tags = {
      RegionName = "ap-southeast-1"
    }
  }
}

# Asia Pacific (Sydney) - ap-southeast-2
provider "aws" {
  alias  = "ap-southeast-2"
  region = "ap-southeast-2"

  default_tags {
    tags = {
      RegionName = "ap-southeast-2"
    }
  }
}

# Canada (Central) - ca-central-1
provider "aws" {
  alias  = "ca-central-1"
  region = "ca-central-1"

  default_tags {
    tags = {
      RegionName = "ca-central-1"
    }
  }
}

# EU (Frankfurt) - eu-central-1
provider "aws" {
  alias  = "eu-central-1"
  region = "eu-central-1"

  default_tags {
    tags = {
      RegionName = "eu-central-1"
    }
  }
}

# EU (Stockholm) - eu-north-1
provider "aws" {
  alias  = "eu-north-1"
  region = "eu-north-1"

  default_tags {
    tags = {
      RegionName = "eu-north-1"
    }
  }
}

# EU (Ireland) - eu-west-1
provider "aws" {
  alias  = "eu-west-1"
  region = "eu-west-1"

  default_tags {
    tags = {
      RegionName = "eu-west-1"
    }
  }
}

# EU (London) - eu-west-2
provider "aws" {
  alias  = "eu-west-2"
  region = "eu-west-2"

  default_tags {
    tags = {
      RegionName = "eu-west-2"
    }
  }
}

# EU (Paris) - eu-west-3
provider "aws" {
  alias  = "eu-west-3"
  region = "eu-west-3"

  default_tags {
    tags = {
      RegionName = "eu-west-3"
    }
  }
}

# South America (Sao Paulo) - sa-east-1
provider "aws" {
  alias  = "sa-east-1"
  region = "sa-east-1"

  default_tags {
    tags = {
      RegionName = "sa-east-1"
    }
  }
}
