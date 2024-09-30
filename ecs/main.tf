
resource "aws_ecs_cluster" "aws_ecs_cluster" {
  name = "${var.environment}-cluster"
}

resource "aws_cloudwatch_log_group" "log_group" {
  name = "${var.environment}-logs"
}

resource "aws_ecs_task_definition" "aws_ecs_task" {
  family = "${var.environment}-task-family"

  container_definitions = jsonencode([
    {
      name : "${var.environment}-container",
      image : "${var.repository_url}:latest",
      entryPoint : [],
      environment : [],
      essential : true,
      logConfiguration : {
        logDriver : "awslogs",
        options : {
          awslogs-group : aws_cloudwatch_log_group.log_group.id,
          awslogs-region : var.region,
          awslogs-stream-prefix : var.environment
        }
      },
      portMappings : [
        {
          containerPort : 8080,
          hostPort : 8080
        }
      ],
      cpu : 256,
      memory : 512,
      networkMode : "awsvpc"
    }
  ])

  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  memory                   = "512"
  cpu                      = "256"
  execution_role_arn       = var.ecs_task_execution_role_arn
  task_role_arn            = var.ecs_task_execution_role_arn
}

data "aws_ecs_task_definition" "main" {
  task_definition = aws_ecs_task_definition.aws_ecs_task.family
}

resource "aws_ecs_service" "aws_ecs_service" {
  name                 = "${var.environment}-ecs-service"
  cluster              = aws_ecs_cluster.aws_ecs_cluster.id
  task_definition      = "${aws_ecs_task_definition.aws_ecs_task.family}:${max(aws_ecs_task_definition.aws_ecs_task.revision, data.aws_ecs_task_definition.main.revision)}"
  launch_type          = "FARGATE"
  scheduling_strategy  = "REPLICA"
  desired_count        = 1
  force_new_deployment = true

  network_configuration {
    subnets          = var.public_subnet_ids
    assign_public_ip = false
    security_groups = [
      var.service_security_group_id,
      var.load_balancer_security_group_id
    ]
  }

  load_balancer {
    target_group_arn = var.lb_target_group_arn
    container_name   = "${var.environment}-container"
    container_port   = 8080
  }

  depends_on = [var.lb_listener]
}

resource "aws_appautoscaling_target" "ecs_target" {
  max_capacity       = 2
  min_capacity       = 1
  resource_id        = "service/${aws_ecs_cluster.aws_ecs_cluster.name}/${aws_ecs_service.aws_ecs_service.name}"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"
}

resource "aws_appautoscaling_policy" "ecs_policy_memory" {
  name               = "${var.environment}-memory-autoscaling"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.ecs_target.resource_id
  scalable_dimension = aws_appautoscaling_target.ecs_target.scalable_dimension
  service_namespace  = aws_appautoscaling_target.ecs_target.service_namespace

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageMemoryUtilization"
    }

    target_value = 80
  }
}

resource "aws_appautoscaling_policy" "ecs_policy_cpu" {
  name               = "${var.environment}-cpu-autoscaling"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.ecs_target.resource_id
  scalable_dimension = aws_appautoscaling_target.ecs_target.scalable_dimension
  service_namespace  = aws_appautoscaling_target.ecs_target.service_namespace

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageCPUUtilization"
    }

    target_value = 80
  }
}
