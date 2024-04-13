# Create subnet group for the database
resource "aws_db_subnet_group" "db_subnet_group" {
  name        = "rds-subnet-group"
  description = "My RDS Subnet Group"
  subnet_ids  = var.subnet_db_ids

  tags = {
    Name = "dbsubnetgroup"
  }
}

# Define primary database
resource "aws_db_instance" "database" {
  identifier              = var.db_instance_name
  allocated_storage       = var.db_allocated_storage
  engine                  = "mysql"
  engine_version          = var.db_engine_version
  instance_class          = var.db_instance_class
  username                = var.master_username
  password                = var.master_user_password
  db_subnet_group_name    = aws_db_subnet_group.db_subnet_group.name
  deletion_protection     = false
  publicly_accessible     = false
  vpc_security_group_ids  = [var.db_sg_id]
  storage_type            = var.storage_type
  multi_az                = var.multi_az
  skip_final_snapshot     = true

  tags = {
    Name = var.db_instance_name
  }
}

# Define read replica
resource "aws_db_instance" "read_replica" {
  identifier              = "terra-read-replica"
  instance_class          = var.db_instance_class
  engine                  = "mysql"  # Specify the database engine
  username                = var.master_username # Specify the username for accessing the read replica
  password                = var.master_user_password  # Specify the password for accessing the read replica
  publicly_accessible     = false
  engine_version          = var.db_engine_version
  allocated_storage       = var.db_allocated_storage
  db_subnet_group_name    = aws_db_subnet_group.db_subnet_group.name
  backup_retention_period = var.backup_retention_period
  replica_mode            = "open-read-only"  # This creates a read replica 

  tags = {
    Name = "ReadReplica"
  }
}
