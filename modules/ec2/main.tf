data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_security_group" "web_sg" {
  name   = "${var.environment_name}-web-sg"
  vpc_id = var.vpc_id

  ingress {
    description = "Allow HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow SSH only from your IP"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["57.132.191.177/32"]
  }

  egress {
    description = "Allow all outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.environment_name}-web-sg"
  }
}

resource "aws_instance" "webserver" {
  count               = 2
  ami                 = data.aws_ami.amazon_linux.id
  instance_type       = "t2.micro"
  subnet_id           = element(var.public_subnets, count.index)
  vpc_security_group_ids = [aws_security_group.web_sg.id]
  key_name            = var.key_pair_name

  user_data = <<EOF
#!/bin/bash
yum update -y
yum install -y httpd
systemctl enable httpd
systemctl start httpd
echo "<h1>Hello from Briana's Web Server</h1>" > /var/www/html/index.html
EOF

  tags = {
    Name = "${var.environment_name}-webserver-${count.index}"
  }
}
