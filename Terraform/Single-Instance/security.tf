resource "aws_security_group" "web_sg" {

  name        = "${var.project_name}-sg"
  description = "Security Group for Flask and Express EC2"
  vpc_id      = var.vpc_id

  tags = {
    Name = "${var.project_name}-sg"
  }
}

##################################################
# SSH
##################################################

resource "aws_vpc_security_group_ingress_rule" "ssh" {

  security_group_id = aws_security_group.web_sg.id

  cidr_ipv4 = var.allowed_ssh_cidr

  from_port = 22
  to_port   = 22

  ip_protocol = "tcp"

  description = "SSH Access"
}

##################################################
# HTTP
##################################################

resource "aws_vpc_security_group_ingress_rule" "http" {

  security_group_id = aws_security_group.web_sg.id

  cidr_ipv4 = "0.0.0.0/0"

  from_port = 80
  to_port   = 80

  ip_protocol = "tcp"

  description = "HTTP Access"
}

##################################################
# HTTPS (Optional)
##################################################

resource "aws_vpc_security_group_ingress_rule" "https" {

  security_group_id = aws_security_group.web_sg.id

  cidr_ipv4 = "0.0.0.0/0"

  from_port = 443
  to_port   = 443

  ip_protocol = "tcp"

  description = "HTTPS Access"
}

##################################################
# Outbound
##################################################

resource "aws_vpc_security_group_egress_rule" "all" {

  security_group_id = aws_security_group.web_sg.id

  cidr_ipv4 = "0.0.0.0/0"

  ip_protocol = "-1"

  description = "Allow all outbound traffic"
}