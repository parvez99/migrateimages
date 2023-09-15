provider "aws" {
  region = var.aws_region
}

resource "aws_iam_role" "this" {
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

data "aws_iam_policy_document" "s3-bucket_policy" {
  statement {
    principals {
      type        = "AWS"
      identifiers = [aws_iam_role.this.arn]
    }

    actions = [
      "s3:ListBucket",
    ]

    resources = [
      "arn:aws:s3:::${var.production-s3}",
      "arn:aws:s3:::${var.legacy-s3}",
    ]
  }
}

resource "aws_s3_bucket" "legacy-s3" {
  bucket = var.legacy-s3

  tags = {
    Name        = "Legacy S3"
    Environment = "Prod"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "legacy-s3-sse" {
  bucket = aws_s3_bucket.legacy-s3.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = var.sse_algorithm
    }
  }
}

resource "aws_s3_object" "legacy-s3-folder" {
  for_each = fileset("data/legacy/", "*")
  bucket = aws_s3_bucket.legacy-s3.id
  key    = "image/${each.value}"
  source = "data/legacy/${each.value}"
}

resource "aws_s3_bucket" "production-s3" {
  bucket = var.production-s3

  tags = {
    Name        = "Production S3"
    Environment = "Prod"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "production-s3-sse" {
  bucket = aws_s3_bucket.production-s3.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = var.sse_algorithm
    }
  }
}

resource "aws_s3_object" "production-s3-folder" {
  for_each = fileset("data/production/", "*")
  source = "data/production/${each.value}"
  bucket = aws_s3_bucket.production-s3.id
  key    = "avatar/${each.value}"
}
