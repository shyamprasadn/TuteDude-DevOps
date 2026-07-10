resource "aws_security_group" "frontend_sg" {

  name        = "frontend-sg"
  description = "Security group for Express frontend"
  vpc_id      = aws_vpc.main.id

  ingress {

    description = "SSH"

    from_port = 22
    to_port   = 22
    protocol  = "tcp"

    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {

    description = "Express App"

    from_port = 3000
    to_port   = 3000
    protocol  = "tcp"

    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {

    from_port = 0
    to_port   = 0
    protocol  = "-1"

    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "frontend-sg"
  }
}

### Backend Security Group ###

resource "aws_security_group" "backend_sg" {

  name        = "backend-sg"
  description = "Security group for Flask backend"
  vpc_id      = aws_vpc.main.id

  ingress {

    description = "SSH"

    from_port = 22
    to_port   = 22
    protocol  = "tcp"

    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {

    description = "Flask App"

    from_port = 5000
    to_port   = 5000
    protocol  = "tcp"

    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {

    from_port = 0
    to_port   = 0
    protocol  = "-1"

    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "backend-sg"
  }
}

### Allow Backend to accept traffic from Frontend Security Group ###

resource "aws_vpc_security_group_ingress_rule" "backend_from_frontend" {
  security_group_id            = aws_security_group.backend_sg.id
  referenced_security_group_id = aws_security_group.frontend_sg.id

  ip_protocol = "tcp"
  from_port   = 5000
  to_port     = 5000
}

### Allow Frontend to accept traffic from Backend Security Group ###

resource "aws_vpc_security_group_ingress_rule" "frontend_from_backend" {
  security_group_id            = aws_security_group.frontend_sg.id
  referenced_security_group_id = aws_security_group.backend_sg.id

  ip_protocol = "tcp"
  from_port   = 3000
  to_port     = 3000
}