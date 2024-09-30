
variable "environment" {
  description = "Iterate over these environments when creating TF State S3 Buckets"
  type        = list(string)
  default     = ["dev", "prd"]
}

variable "aws_region" {
  description = "N. Virginia US East 1"
  type        = string
  default     = "us-east-1"
}
