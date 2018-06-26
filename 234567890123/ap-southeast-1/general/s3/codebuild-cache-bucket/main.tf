terraform {
  backend "s3" {
    bucket         = "<PD-development-terraform-state-bucket>"
    key            = "ap-southeast-1/general/s3/codebuild-cache-bucket/terraform.tfstate"
    region         = "ap-southeast-1"
    dynamodb_table = "<PD-development-terraform-state-dynamodb>"
  }
}

provider "aws" {
  region = "ap-southeast-1"
}

module "this_name" {
  source = "github.com/traveloka/terraform-aws-resource-naming?ref=v0.7.1"

  name_prefix   = "PD-codebuild-cache-234567890123-"
  resource_type = "s3_bucket"
}

resource "aws_s3_bucket" "this" {
  bucket        = "${module.this_name.name}"
  acl           = "private"
  force_destroy = true
  region        = "ap-southeast-1"

  versioning {
    enabled = true
  }

  lifecycle_rule {
    enabled                                = true
    abort_incomplete_multipart_upload_days = 1

    expiration {
      expired_object_delete_marker = true
    }

    noncurrent_version_expiration {
      days = 7
    }
  }

  tags {
    ProductDomain = "abc"
    Description   = "Cache bucket for abc's CodeBuild projects"
    Environment   = "special"
  }
}
