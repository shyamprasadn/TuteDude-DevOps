output "cluster_name" {
  value = aws_ecs_cluster.this.name
}

output "cluster_arn" {
  value = aws_ecs_cluster.this.arn
}

output "ecs_task_role_arn" {
  value = data.aws_iam_role.ecs_task_role.arn
}