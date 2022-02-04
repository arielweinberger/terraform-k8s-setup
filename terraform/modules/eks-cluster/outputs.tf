output "cluster_id" {
  description = "EKS cluster ID."
  value       = module.eks.cluster_id
}

output "cluster_name" {
  description = "Kubernetes Cluster Name"
  value       = local.cluster_name
}

output "cluster_endpoint" {
  description = "Endpoint for EKS control plane."
  value       = module.eks.cluster_endpoint
}

output "cluster_token" {
  value = data.aws_eks_cluster_auth.cluster.token
}

output "cluster_ca_certificate" {
  value = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
}

### VPC ###

output "cluster_vpc_private_subnets_cidr_block" {
  value = module.vpc.private_subnets_cidr_blocks
}

output "cluster_vpc_database_subnets" {
  value = module.vpc.database_subnets
}

output "cluster_vpc_id" {
  value = module.vpc.vpc_id
}

output "cluster_vpc_subnets" {
  value = module.vpc.private_subnets
}

output "cluster_subnets_cidr_blocks" {
  value = module.vpc.private_subnets_cidr_blocks
}

output "cluster_primary_security_group_id" {
  value = module.eks.cluster_primary_security_group_id
}

output "external_dns_deployment_status" {
  value = module.eks_external_dns.helm_chart_status
}