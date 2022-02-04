variable db_name {
  type = string
  description = "Database name (e.g. \"codingly\")"
}

variable vpc_id {
  type = string
  description = "VPC ID to spawn the database in"
}

variable subnet_ids {
  type = list(string)
  description = "Array of subnet IDs to spawn the database in"
}

variable allowed_cidr_blocks {
  type = list(string)
  description = "CIDR blocks"
}

variable stage {
  type = string
}