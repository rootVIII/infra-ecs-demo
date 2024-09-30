
variable "environment" {
  description = "Set in root module"
  type        = string
}

variable "region" {
  description = "Set in root module"
  type        = string
}

variable "repository_url" {
  description = "ECS Container Image URL"
  type        = string
}

variable "public_subnet_ids" {
  description = "Output Public Subnet IDs from ../network/"
  type        = list(string)
}

variable "vpc_id" {
  description = "Output VPC ID from ../network/"
  type        = string
}

variable "ecs_task_execution_role_arn" {
  description = "Output ARN from ../iam"
  type        = string
}

variable "service_security_group_id" {
  description = "Output Service SG ID from ../security_groups/"
  type        = string
}

variable "load_balancer_security_group_id" {
  description = "Output LB SG ID from ../security_groups/"
  type        = string
}

variable "lb_target_group_arn" {
  description = "Output ARN IDs from ../network/"
  type        = string
}

variable "lb_listener" {
  description = "Output LB Listener from ../network/"
  type        = object({})
}
