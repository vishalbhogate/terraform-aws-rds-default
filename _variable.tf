variable "allocated_storage" {
  description = "The allocated storage in gibibytes."
}

variable "storage_type" {
  description = "Specifies the storage type to be associated with the DB instance."
  default     = "gp2"
}

variable "engine" {
  default     = ""
  description = "The name of the database engine that you want to use for this DB instance"
}

variable "engine_version" {
  description = "The version number of the database engine to use."
  default     = ""
}

variable "instance_class" {
  type        = string
  description = "The instance type of the RDS instance."
}

variable "name" {
  type        = string
  description = "The name of the database to create when the DB instance is created."
  default     = ""
}

variable "family" {
  type        = string
  description = "The family of the DB parameter group."
}

variable "backup_retention_period" {
  description = "The days to retain backups for. Must be between 0 and 35."
  default     = 0
}

variable "identifier" {
  type        = string
  description = "The name of the RDS instance, if omitted, Terraform will assign a random, unique identifier."
  default     = ""
}

variable "username" {
  type        = string
  description = "Username for the master DB user."
}

variable "account_name" {
  type        = string
  description = "Account name in which rds will get deployed."
}

variable "vpc_security_group_ids" {
  description = "List of VPC security groups to associate"
  default     = [""]
}

variable "apply_immediately" {
  description = "Specifies whether any database modifications are applied immediately, or during the next maintenance window."
  default     = false
}

variable "skip_final_snapshot" {
  description = "Determines whether a final DB snapshot is created before the DB instance is deleted."
  default     = false
}

variable "snapshot_identifier" {
  type        = string
  description = "Specifies whether or not to create this database from a snapshot."
  default     = ""
}

variable "deletion_protection" {
  description = "The database can't be deleted when this value is set to true."
  default     = false
}
