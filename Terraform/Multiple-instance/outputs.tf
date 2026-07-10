output "vpc_id" {
  value = aws_vpc.main.id
}

output "frontend_subnet_id" {
  value = aws_subnet.frontend.id
}

output "backend_subnet_id" {
  value = aws_subnet.backend.id
}

output "frontend_public_ip" {
  value = aws_instance.frontend.public_ip
}

output "frontend_private_ip" {
  value = aws_instance.frontend.private_ip
}

output "backend_public_ip" {
  value = aws_instance.backend.public_ip
}

output "backend_private_ip" {
  value = aws_instance.backend.private_ip
}