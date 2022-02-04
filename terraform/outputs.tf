output "workspace" {
  value = terraform.workspace
}

output "region" {
  value       = var.region
  description = "AWS Region"
}

output "cluster_name" {
  value       = module.eks_cluster.cluster_name
  description = "EKS Cluster Name"
}

output "cluster_vpc_id" {
  value = module.eks_cluster.cluster_vpc_id
}