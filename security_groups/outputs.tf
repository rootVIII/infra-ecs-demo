
output "lb_sg_id" {
  description = "Load Balancer Security Group ID"
  value       = aws_security_group.load_balancer_security_group.id
}

output "service_security_group_id" {
  description = "AWS Security Group ID for the service"
  value       = aws_security_group.service_security_group.id
}

output "load_balancer_security_group_id" {
  description = "AWS Security Group ID for the LB"
  value       = aws_security_group.load_balancer_security_group.id
}
