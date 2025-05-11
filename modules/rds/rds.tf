# DB subnet group
resource "aws_db_subnet_group" "this" {
  name       = "db-subnet-group"
  subnet_ids = var.subnet_ids
  tags = {
    Name = "db-subnet-group"
  }
}

# RDS instance
resource "aws_db_instance" "this" {
  identifier              = "wp-db"
  engine                  = var.engine
  engine_version          = var.engine_version
  instance_class          = var.instance_class
  allocated_storage       = var.allocated_storage
  storage_type            = var.storage_type
  username                = var.username
  password                = var.password
  db_subnet_group_name    = aws_db_subnet_group.this.name
  vpc_security_group_ids  = [var.security_group_id]
  availability_zone       = var.availability_zone
  multi_az                = false
  publicly_accessible     = false
  skip_final_snapshot     = true

  tags = {
    Name = "wp-db"
  }
}