terraform {
  backend "s3" {
    bucket = "codingly-terraform-remote-states"
    key    = "codingly-tf-state"
    region = "eu-west-1"
  }

  required_version = ">= 1.0.11"
}

provider "helm" {
  kubernetes {
    host                   = module.eks_cluster.cluster_endpoint
    cluster_ca_certificate = module.eks_cluster.cluster_ca_certificate

    exec {
      api_version = "client.authentication.k8s.io/v1alpha1"
      args        = ["eks", "get-token", "--cluster-name", module.eks_cluster.cluster_name]
      command     = "aws"
    }
  }
}

provider "kubernetes" {
  host                   = module.eks_cluster.cluster_endpoint
  cluster_ca_certificate = module.eks_cluster.cluster_ca_certificate

  exec {
    api_version = "client.authentication.k8s.io/v1alpha1"
    args        = ["eks", "get-token", "--cluster-name", module.eks_cluster.cluster_name]
    command     = "aws"
  }
}

provider "aws" {
  region              = var.region
  allowed_account_ids = [local.workspace.aws_account_id] // dev only
}

### Kubernetes ###

module "eks_cluster" {
  source                       = "./modules/eks-cluster"
  region                       = var.region
  cluster_name                 = "codingly-eks-${local.workspace.stage}"
  environment                  = local.workspace.stage
  external_dns_zone_id_filters = local.workspace.external_dns_zone_id_filters
  instance_type                = local.workspace.eks_instance_type
  desired_capacity             = local.workspace.eks_desired_capacity
}

module "ecr_repository" {
  source              = "./modules/ecr"
  ecr_repository_name = "codingly-${local.workspace.stage}"
  stage               = local.workspace.stage
}

### PERSISTENCE ###

module "aurora_db" {
  stage               = local.workspace.stage
  depends_on          = [module.eks_cluster.cluster_vpc_id]
  source              = "./modules/aurora-db"
  db_name             = "codingly-${local.workspace.stage}"
  vpc_id              = module.eks_cluster.cluster_vpc_id
  subnet_ids          = module.eks_cluster.cluster_vpc_database_subnets
  allowed_cidr_blocks = module.eks_cluster.cluster_vpc_private_subnets_cidr_block
}
