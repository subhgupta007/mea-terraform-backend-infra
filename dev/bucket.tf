# S3 Bucket for Terraform Backend
resource "aws_s3_bucket" "MEA_terraform_backend_dev" {
  bucket = "mea-terraform-backend-dev"

  lifecycle {
    prevent_destroy = true
  }

  tags = {
    Environment = "dev"
    Service     = "MEA-terraform-backend-terraform-infra"
  }
}

# Versioning Configuration
resource "aws_s3_bucket_versioning" "MEA_terraform_backend_dev" {
  bucket = aws_s3_bucket.MEA_terraform_backend_dev.id

  versioning_configuration {
    status = "Enabled"
  }
}

# Server-side Encryption Configuration
resource "aws_s3_bucket_server_side_encryption_configuration" "MEA_terraform_backend_dev" {
  bucket = aws_s3_bucket.MEA_terraform_backend_dev.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# Public Access Block
resource "aws_s3_bucket_public_access_block" "MEA_terraform_backend_dev" {
  bucket = aws_s3_bucket.MEA_terraform_backend_dev.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

