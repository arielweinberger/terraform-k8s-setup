resource "aws_ssm_parameter" "cluster_master_username" {
  name = "/${var.stage}/aurora-cluster-master-username"
  value = module.db.cluster_master_username
  type = "String"
}

resource "aws_ssm_parameter" "cluster_master_password" {
  name = "/${var.stage}/aurora-cluster-master-password"
  value = module.db.cluster_master_password
  type = "String"
}

resource "aws_ssm_parameter" "cluster_master_port" {
  name = "/${var.stage}/aurora-cluster-port"
  value = module.db.cluster_port
  type = "String"
}

resource "aws_ssm_parameter" "cluster_endpoint" {
  name = "/${var.stage}/aurora-cluster-endpoint"
  value = module.db.cluster_endpoint
  type = "String"
}