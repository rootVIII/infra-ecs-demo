
output "aws_region" {
  description = "Current region"
  value       = var.region
}

output "vpc_id" {
  description = "VPC ID"
  value       = aws_vpc.dev_vpc.id
}

output "public_subnet_ids" {
  description = "VPC Public Subnet"
  value       = aws_subnet.public_subnet.*.id
}

output "aws_lb_target_group_arn" {
  description = "LB Target Group ARN"
  value       = aws_lb_target_group.target_group.arn
}

output "aws_lb_listener" {
  description = "LB Listener"
  value       = aws_lb_listener.listener
}