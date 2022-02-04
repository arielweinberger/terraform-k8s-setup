resource "aws_db_parameter_group" "aurora_db_parameter_group" {
  name        = "${var.db_name}-parameter-group"
  family      = "aurora-postgresql10"
  description = "${var.db_name}-parameter-group"
}

resource "aws_rds_cluster_parameter_group" "aurora_cluster_parameter_group" {
  name        = "${var.db_name}-parameter-group"
  family      = "aurora-postgresql10"
  description = "${var.db_name}-parameter-group"
}

module "db" {
  source  = "terraform-aws-modules/rds-aurora/aws"

  name              = "${var.db_name}-db-postgres"
  engine            = "aurora-postgresql"
  engine_mode       = "serverless"
  storage_encrypted = true

  vpc_id                = var.vpc_id
  subnets               = var.subnet_ids
  create_security_group = true
  allowed_cidr_blocks   = var.allowed_cidr_blocks

  monitoring_interval = 60

  apply_immediately   = true
  skip_final_snapshot = true

  db_parameter_group_name         = aws_db_parameter_group.aurora_db_parameter_group.id
  db_cluster_parameter_group_name = aws_rds_cluster_parameter_group.aurora_cluster_parameter_group.id

  scaling_configuration = {
    auto_pause               = true
    min_capacity             = 2
    max_capacity             = 16
    seconds_until_auto_pause = 300
    timeout_action           = "ForceApplyCapacityChange"
  }
}