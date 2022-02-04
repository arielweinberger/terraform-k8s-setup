resource "aws_ssm_parameter" "eks_cluster_kubeconfig" {
  name = "/${var.environment}/eks-cluster-kubeconfig"
  value = base64encode(module.eks.kubeconfig)
  type = "String"
}

resource "aws_ssm_parameter" "cluster_name" {
  name  = "/${var.environment}/eks-full-cluster-name"
  type  = "String"
  value = local.cluster_name
}

resource "aws_ssm_parameter" "cluster_endpoint" {
  name  = "/${var.environment}/eks-cluster-endpoint"
  type  = "String"
  value = module.eks.cluster_endpoint
}

resource "aws_ssm_parameter" "cluster_iam_role_arn" {
  name  = "/${var.environment}/eks-cluster-iam-role-arn"
  type  = "String"
  value = module.eks.cluster_iam_role_arn
}

resource "aws_ssm_parameter" "worker_iam_role_arn" {
  name  = "/${var.environment}/eks-worker-iam-role-arn"
  type  = "String"
  value = module.eks.worker_iam_role_arn
}