output "bucket_name" {
  value       = "${aws_s3_bucket.this.id}"
  description = "the name of PD's cache bucket"
}

output "bucket_arn" {
  value       = "${aws_s3_bucket.this.arn}"
  description = "the ARN of PD's cache bucket"
}
