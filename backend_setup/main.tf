
resource "aws_s3_bucket" "buckets" {
  count         = length(var.environment)
  bucket        = "${var.environment[count.index]}-tfstate-storage"
  force_destroy = true
}

resource "aws_ecr_repository" "aws-ecr" {
  count        = length(var.environment)
  name         = "${var.environment[count.index]}-ecr-repo"
  force_delete = true
}
