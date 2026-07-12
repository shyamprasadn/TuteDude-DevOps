resource "aws_ecs_service" "backend" {

  name            = "${var.project_name}-backend"
  cluster         = aws_ecs_cluster.this.id
  task_definition = aws_ecs_task_definition.backend.arn

  desired_count = 1

  launch_type = "FARGATE"

  network_configuration {

    subnets = var.subnet_ids

    security_groups = [
      var.backend_security_group_id
    ]

    assign_public_ip = true
  }

  load_balancer {

    target_group_arn = var.backend_target_group_arn

    container_name = "backend"

    container_port = 5000
  }
}

resource "aws_ecs_service" "frontend" {

  name            = "${var.project_name}-frontend"
  cluster         = aws_ecs_cluster.this.id
  task_definition = aws_ecs_task_definition.frontend.arn

  desired_count = 1

  launch_type = "FARGATE"

  network_configuration {

    subnets = var.subnet_ids

    security_groups = [
      var.frontend_security_group_id
    ]

    assign_public_ip = true
  }

  load_balancer {

    target_group_arn = var.frontend_target_group_arn

    container_name = "frontend"

    container_port = 3000
  }
}