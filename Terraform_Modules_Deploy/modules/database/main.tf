# Create subnet group for the database
resource "aws_db_subnet_group" "db_subnet_group" {
  name        = "rds-subnet-group"
  description = "My RDS Subnet Group"
  subnet_ids  = var.db_subnet_ids

  tags = {
    Name = "dbsubnetgroup"
  }
}

# Define primary database
resource "aws_db_instance" "primary_database" {
  identifier              = var.db_instance_name
  allocated_storage       = var.db_allocated_storage
  engine                  = "mysql"
  engine_version          = "8.0.34"
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
  backup_retention_period = 7
  tags = {
    Name = var.db_instance_name
  }
}

# Define the read replica
# db_subnet_group_name    = aws_db_subnet_group.db_subnet_group.name // no need when it's in the same region with the primary
resource "aws_db_instance" "read_replica" {

  instance_class          = var.db_instance_class
  publicly_accessible     = false
  replicate_source_db     = aws_db_instance.primary_database.identifier //I added 'identifier' instead of id to identify the primary source
  availability_zone       = var.read_replica_az
  backup_retention_period = 7
  skip_final_snapshot     = true
  
  depends_on = [
    aws_db_instance.primary_database
  ]

  tags = {
    Name = "ReadReplica"
  }
}