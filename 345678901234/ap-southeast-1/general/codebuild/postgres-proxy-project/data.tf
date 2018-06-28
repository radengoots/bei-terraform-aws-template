data "terraform_remote_state" "service_role" {
  backend = "s3"

  config {
    bucket         = "<PD-production-terraform-state-bucket>"
    key            = "ap-southeast-1/general/iam_role/postgres-proxy-publisher/terraform.tfstate"
    region         = "ap-southeast-1"
    dynamodb_table = "<PD-production-terraform-state-dynamodb>"
  }
}
