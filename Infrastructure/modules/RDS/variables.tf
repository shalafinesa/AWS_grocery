variable "db_identifier" {
  description = "The RDS instance identifier"
  type        = string
}

variable "db_name" {
  description = "The database name"
  type        = string
}

variable "db_username" {
  description = "The master username for the database"
  type        = string
}

variable "db_password" {
  description = "The master password for the database"
  type        = string
  sensitive   = true
}

variable "db_allocated_storage" {
  description = "The allocated storage in GB"
  type        = number
}

variable "db_instance_class" {
  description = "The instance type of the RDS instance"
  type        = string
}

variable "db_engine" {
  description = "The database engine"
  type        = string
}

variable "db_engine_version" {
  description = "The engine version"
  type        = string
  default     = "14.19"
}

variable "db_security_group_ids" {
  description = "List of security group IDs for the DB"
  type        = list(string)
}

variable "db_publicly_accessible" {
  description = "Whether the DB is publicly accessible"
  type        = bool
  default     = false
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs for the DB subnet group"
  type        = list(string)
}
