resource "aws_instance" "frontend" {

  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name

  subnet_id                   = aws_subnet.frontend.id
  vpc_security_group_ids      = [aws_security_group.frontend_sg.id]
  associate_public_ip_address = true

  user_data = templatefile(
    "${path.module}/userdata/frontend.sh",
    {
      github_repo       = var.github_repo
      github_branch     = var.github_branch
      backend_public_ip = aws_instance.backend.public_ip
    }
  )

  user_data_replace_on_change = true

  tags = merge(local.common_tags, {
    Name = "frontend-ec2"
  })
}