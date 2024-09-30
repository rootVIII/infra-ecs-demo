
variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnets" {
  description = "Public subnet for VPC"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "availability_zones" {
  description = "VPC zones"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}

variable "lb_sg_id" {
  description = "Output load balancer security-group ID from VPC from ../security_groups/"
  type        = string
}

variable "environment" {
  description = "Set in root module"
  type        = string
}

variable "region" {
  description = "Set in root module"
  type        = string
}
