terraform {
  backend "s3" {
    bucket         = "<PD-development-terraform-state-bucket>"
    key            = "ap-southeast-1/general/codebuild/distributed-job-proxy/terraform.tfstate"
    region         = "ap-southeast-1"
    dynamodb_table = "<PD-development-terraform-state-dynamodb>"
  }
}

provider "aws" {
  region = "ap-southeast-1"
}

module "this" {
  source = "github.com/traveloka/terraform-aws-codebuild-postgres-proxy-publisher?ref=v0.3.1"

  product_domain  = "${local.product_domain}"
  jar_name        = "${local.jar_name}"
  source_location = "${local.source_location}"
  project_path    = "${local.project_path}"
  service_role    = "${data.terraform_remote_state.service_role.role_name}"
  git_clone_depth = 1
}
