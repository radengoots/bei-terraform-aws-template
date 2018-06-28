output "codebuild_project_name" {
  description = "The name of ${local.jar_name} CodeBuild project"
  value       = "${module.this.codebuild_project}"
}
