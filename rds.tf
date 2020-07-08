resource random_string "rds_apps_passowrd" {
  length  = 34
  special = false
}

resource aws_db_instance "default" {
  allocated_storage       = var.allocated_storage
  storage_type            = var.storage_type
  engine                  = var.engine
  engine_version          = var.engine_version
  instance_class          = var.instance_class
  name                    = var.name
  backup_retention_period = var.backup_retention_period
  identifier              = var.identifier
  username                = var.username
  password                = random_string.rds_apps_passowrd.result
  parameter_group_name    = aws_db_parameter_group.default.id
  vpc_security_group_ids  = var.vpc_security_group_ids
  apply_immediately       = var.apply_immediately
  skip_final_snapshot     = var.skip_final_snapshot
  snapshot_identifier     = var.snapshot_identifier != "" ? var.snapshot_identifier : null
  deletion_protection     = var.deletion_protection
  db_subnet_group_name    = "${var.account_name}-dbsubnet" # Created as part of network stack
}

resource aws_db_parameter_group "default" {
  name   = var.name
  family = var.family

  parameter {
    name  = "sql_mode"
    value = "NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION"
  }
}

resource aws_ssm_parameter "rds_password" {
  name        = "/rds/${var.identifier}/password"
  description = "RDS Password"
  type        = "SecureString"
  value       = random_string.rds_apps_passowrd.result

  lifecycle {
    ignore_changes = [value]
  }
}

resource aws_ssm_parameter "rds_user" {
  name        = "/rds/${var.identifier}/user"
  description = "RDS User"
  type        = "SecureString"
  value       = var.username
}

resource aws_ssm_parameter "rds_endpoint" {
  name        = "/rds/${var.identifier}/endpoint"
  description = "RDS Endpoint"
  type        = "String"
  value       = aws_db_instance.default.endpoint
}

resource aws_ssm_parameter "rds_address" {
  name        = "/rds/${var.identifier}/address"
  description = "RDS Address"
  type        = "String"
  value       = aws_db_instance.default.address
}

resource aws_ssm_parameter "rds_name" {
  name        = "/rds/${var.identifier}/name"
  description = "RDS DB Name"
  type        = "String"
  value       = aws_db_instance.default.name
}
