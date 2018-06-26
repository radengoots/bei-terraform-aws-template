data "aws_iam_policy_document" "write_to_artifact_bucket" {
  statement {
    effect = "Allow"

    actions = [
      "s3:PutObject",
    ]

    resources = [
      "arn:aws:s3:::${data.terraform_remote_state.artifact_bucket.bucket_name}/abcb/*",
    ]
  }
}

data "terraform_remote_state" "cache_bucket" {
  backend = "s3"

  config {
    bucket         = "<PD-development-terraform-state-bucket>"
    key            = "ap-southeast-1/general/s3/codebuild-cache-bucket/terraform.tfstate"
    region         = "ap-southeast-1"
    dynamodb_table = "<PD-development-terraform-state-dynamodb>"
  }
}

data "terraform_remote_state" "artifact_bucket" {
  backend = "s3"

  config {
    bucket         = "<PD-development-terraform-state-bucket>"
    key            = "ap-southeast-1/general/s3/service-artifact-bucket/terraform.tfstate"
    region         = "ap-southeast-1"
    dynamodb_table = "<PD-development-terraform-state-dynamodb>"
  }
}
