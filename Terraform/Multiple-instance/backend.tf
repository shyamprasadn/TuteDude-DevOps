resource "aws_instance" "backend" {

  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name

  subnet_id                   = aws_subnet.backend.id
  vpc_security_group_ids      = [aws_security_group.backend_sg.id]
  associate_public_ip_address = true

  user_data = templatefile(
    "${path.module}/userdata/backend.sh",
    {
      github_repo   = var.github_repo
      github_branch = var.github_branch
    }
  )

  user_data_replace_on_change = true

  tags = merge(local.common_tags, {
    Name = "backend-ec2"
  })
}