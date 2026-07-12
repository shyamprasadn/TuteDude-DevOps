data "aws_iam_role" "ecs_task_role" {
  name = "ECS-Task-role"
}

resource "aws_ecs_cluster" "this" {
  name = "${var.project_name}-cluster"

  tags = var.common_tags
}