
module "network" {
  source      = "../../network"
  environment = var.environment
  region      = var.region
  lb_sg_id    = module.security_groups.lb_sg_id
}

module "security_groups" {
  source = "../../security_groups"
  vpc_id = module.network.vpc_id
}

module "ecs" {
  source                          = "../../ecs"
  environment                     = var.environment
  region                          = var.region
  repository_url                  = var.repository_url
  vpc_id                          = module.network.vpc_id
  public_subnet_ids               = module.network.public_subnet_ids
  lb_target_group_arn             = module.network.aws_lb_target_group_arn
  lb_listener                     = module.network.aws_lb_listener
  ecs_task_execution_role_arn     = module.iam.ecs_task_execution_role_arn
  service_security_group_id       = module.security_groups.service_security_group_id
  load_balancer_security_group_id = module.security_groups.load_balancer_security_group_id
}

module "iam" {
  source      = "../../iam"
  environment = var.environment
}
