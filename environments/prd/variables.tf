
variable "namespace" {
  description = "value"
  type        = string
}

variable "environment" {
  description = "Current infrastructure environment"
  type        = string
}

variable "region" {
  description = "AWS Region"
  type        = string
}

variable "repository_url" {
  description = "ECS Container Image URL"
  type        = string
}
