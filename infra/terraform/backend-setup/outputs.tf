output "s3_bucket_name" {
  value       = devops-stage-6-terraform-state-ifeanyinw
  description = "Name of the S3 bucket for Terraform state"
}

output "s3_bucket_arn" {
  value       = aws_s3_bucket.terraform_state.arn
  description = "ARN of the S3 bucket for Terraform state"
}

output "dynamodb_table_name" {
  value       = terraform-locks
  description = "Name of the DynamoDB table for state locking"
}

output "dynamodb_table_arn" {
  value       = aws_dynamodb_table.terraform_locks.arn
  description = "ARN of the DynamoDB table for state locking"
}

output "backend_config" {
  value = <<-EOT
    
    Add this to your terraform/infrastructure/backend.tf:
    
    terraform {
      backend "s3" {
        bucket         = "${devops-stage-6-terraform-state-ifeanyinw}"
        key            = "microservice/terraform.tfstate"
        region         = "${var.aws_region}"
        dynamodb_table = "${terraform-locks}"
        encrypt        = true
      }
    }
  EOT
  description = "Backend configuration to use in your main Terraform code"
}