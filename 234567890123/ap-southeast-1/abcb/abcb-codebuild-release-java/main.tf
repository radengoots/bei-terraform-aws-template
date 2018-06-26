provider "aws" {
  region = "ap-southeast-1"
}

module "codebuild" {
  source         = "traveloka/codebuild-traveloka-backend-release/aws"
  version        = "0.3.0"
  name           = "abcb-release-build"
  service_name   = "abcb"
  product_domain = "bei"
  description    = "build project for abcb release"
  cache_bucket   = "${data.terraform_remote_state.cache_bucket.bucket_name}"

  build_commands = [
    "./gradlew uploadDistTar",
  ]

  additional_policies = [
    "${data.aws_iam_policy_document.write_to_artifact_bucket.json}",
  ]

  source_repository_url = "https://github.com/traveloka/backend-abcb.git"
}
