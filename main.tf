terraform {
required_providers {
aws = {
source = "hashicorp/aws"
version = "3.44.0"
region = var.region          
  }
}

resource "random_uuid" "randomid" {}

resource "aws_s3_bucket" "app" {
  tags = {
    Name          = "App Bucket"
    public_bucket = true
  }

  bucket        = "${var.app}.${var.label}.${random_uuid.randomid.result}"
  force_destroy = true
}

resource "aws_s3_bucket_ownership_controls" "app" {
  bucket = aws_s3_bucket.app.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_public_access_block" "app" {
  bucket = aws_s3_bucket.app.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_acl" "app" {
  depends_on = [
    aws_s3_bucket_ownership_controls.app,
    aws_s3_bucket_public_access_block.app,
  ]

  bucket = aws_s3_bucket.app.id
  acl    = "public-read"
}


