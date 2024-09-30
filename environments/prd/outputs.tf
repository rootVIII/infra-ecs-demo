
output "environment" {
  description = "Infrastructure Environment"
  value       = var.environment
}

output "region" {
  description = "region"
  value       = var.region
}

output "task_definition" {
  description = "TASK Definition JSON"
  value       = module.ecs.ecs_task_definition
}