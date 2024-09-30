
output "ecs_cluster_name" {
  description = "IP address of bastion host EC2 instance"
  value       = aws_ecs_cluster.aws_ecs_cluster.name
}

output "ecs_task_definition" {
  description = "Task Definition JSON"
  value       = aws_ecs_task_definition.aws_ecs_task.container_definitions
}