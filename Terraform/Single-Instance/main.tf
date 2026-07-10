
resource "aws_instance" "web_server" {

  ami                    = var.ami_id

  instance_type          = var.instance_type

  subnet_id              = var.subnet_id

  vpc_security_group_ids = [
    aws_security_group.web_sg.id
  ]

  key_name = var.key_name

  associate_public_ip_address = true

  user_data = templatefile("${path.module}/userdata.sh", {
    github_repo_url = var.github_repo_url
    github_branch   = var.github_branch
  })

  tags = {
    Name = "${var.project_name}-ec2"
  }
}