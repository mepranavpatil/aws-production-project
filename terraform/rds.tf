# ==========================================
# rds.tf
# RDS MySQL Database in Private Subnet
# ==========================================

# --- DB Subnet Group ---
# Tells RDS which subnets it can use
resource "aws_db_subnet_group" "main" {
  name       = "${var.project_name}-db-subnet-group"
  subnet_ids = aws_subnet.private[*].id

  tags = {
    Name    = "${var.project_name}-db-subnet-group"
    Project = var.project_name
  }
}

# --- RDS MySQL Instance ---
resource "aws_db_instance" "main" {
  identifier        = "${var.project_name}-mysql"
  engine            = "mysql"
  engine_version    = var.db_engine_version
  instance_class    = var.db_instance_class
  allocated_storage = var.db_allocated_storage

  db_name  = var.db_name
  username = var.db_username
  password = var.db_password

  db_subnet_group_name   = aws_db_subnet_group.main.name
  vpc_security_group_ids = [aws_security_group.rds.id]

  skip_final_snapshot = true
  deletion_protection = false

  backup_retention_period = 7
  backup_window           = "03:00-04:00"
  maintenance_window      = "Mon:04:00-Mon:05:00"

  multi_az               = false
  publicly_accessible    = false
  storage_encrypted      = true

  tags = {
    Name    = "${var.project_name}-mysql"
    Project = var.project_name
  }
}