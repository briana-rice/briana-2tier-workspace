resource "aws_security_group" "rds_sg" {
  name   = "${var.environment_name}-rds-sg"
  vpc_id = var.vpc_id

  ingress {
    description    = "MySQL inbound"
    from_port      = 3306
    to_port        = 3306
    protocol       = "tcp"
    security_groups = [var.web_sg_id]
  }

  egress {
    description = "All outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.environment_name}-rds-sg"
  }
}

resource "aws_db_subnet_group" "this" {
  name       = "${var.environment_name}-rds-subnet-group"
  subnet_ids = var.private_subnets
  tags = {
    Name = "${var.environment_name}-rds-subnet-group"
  }
}

resource "aws_db_instance" "this" {
  identifier              = "${var.environment_name}-mysql-db"
  allocated_storage       = 20
  engine                  = "mysql"
  engine_version          = "8.0"
  instance_class          = "db.t2.micro"
  db_name                 = var.db_name
  username                = var.db_username
  password                = var.db_password
  db_subnet_group_name    = aws_db_subnet_group.this.name
  vpc_security_group_ids  = [aws_security_group.rds_sg.id]
  skip_final_snapshot     = true
  publicly_accessible     = false
  multi_az                = false
  tags = {
    Name = "${var.environment_name}-rds-instance"
  }
}
