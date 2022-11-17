# S3 Bucket to store data with lifecycle rules and versioning options
resource "aws_s3_bucket" "s3bucket" {
  bucket = var.bucket_name

  tags = merge(
    var.tags,
    {
      Name = var.bucket_name,
    }
  )

  lifecycle {
    prevent_destroy = true
  }
}

# Make sure the bucket uses encryption
resource "aws_s3_bucket_server_side_encryption_configuration" "s3bucket_encryption" {
  bucket = aws_s3_bucket.s3bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }

  lifecycle {
    prevent_destroy = true
  }
}

# Configure public or private bucket acl
resource "aws_s3_bucket_acl" "s3bucket_acl" {
  bucket = aws_s3_bucket.s3bucket.id
  acl    = var.bucket_acl

  lifecycle {
    prevent_destroy = true
  }
}

# Setup bucket versioning to make sure data is not tampered with
resource "aws_s3_bucket_versioning" "s3bucket_versioning" {
  bucket = aws_s3_bucket.s3bucket.id

  versioning_configuration {
    status = var.enable_bucket_versioning
  }

  lifecycle {
    prevent_destroy = true
  }
}

# Enable lifecycle rules to handle purging old data on non-current versions
resource "aws_s3_bucket_lifecycle_configuration" "s3bucket_lifecycle" {
  bucket = aws_s3_bucket.s3bucket.id

  rule {
    id     = "clean"
    status = var.enable_lifecycle_rules

    transition {
      days          = var.lifecycle_move_to_standard_ia
      storage_class = "STANDARD_IA"
    }

    transition {
      days          = var.lifecycle_move_to_glacier
      storage_class = "GLACIER"
    }

    expiration {
      days = var.lifecycle_expiration
    }
  }

  rule {
    id     = "expire_versions"
    status = var.enable_lifecycle_rules

    noncurrent_version_expiration {
      noncurrent_days = var.expire_noncurrent_versions_in_days
    }
  }

  lifecycle {
    prevent_destroy = true
  }

  # Must have bucket versioning enabled first
  depends_on = [
    aws_s3_bucket_versioning.s3bucket_versioning
  ]
}

# Attach s3 bucket policy to s3 bucket
resource "aws_s3_bucket_policy" "s3bucket_policy" {
  count = var.enable_s3_policy ? 1 : 0

  bucket = aws_s3_bucket.s3bucket.id
  policy = var.s3_bucket_policy
}

# Add global bucket policy defaults
resource "aws_s3_bucket_public_access_block" "s3bucket_public_access" {
  bucket = aws_s3_bucket.s3bucket.id

  block_public_acls       = var.block_public_acls
  block_public_policy     = var.block_public_policy
  ignore_public_acls      = var.ignore_public_acls
  restrict_public_buckets = var.restrict_public_buckets

  lifecycle {
    prevent_destroy = true
  }
}
