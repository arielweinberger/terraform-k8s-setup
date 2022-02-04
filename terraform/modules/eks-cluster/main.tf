module "eks" {
  depends_on = [module.vpc.vpc_id]
  source           = "terraform-aws-modules/eks/aws"
  
  cluster_name     = local.cluster_name
  cluster_version  = "1.21"
  subnets          = module.vpc.private_subnets
  enable_irsa      = true
  write_kubeconfig = false

  tags = {
  }

  vpc_id = module.vpc.vpc_id

  workers_group_defaults = {
    root_volume_type = "gp2"
  }

  worker_groups = [
    {
      name                          = "worker-group-t2"
      instance_type                 = var.instance_type
      additional_userdata           = "echo foo bar"
      asg_desired_capacity          = var.desired_capacity
      additional_security_group_ids = [aws_security_group.worker_group_mgmt_one.id]
    }
  ]

  map_users = [
    {
      userarn  = "arn:aws:iam::870065213604:user/ops"
      username = "ops"
      groups   = ["system:masters"]
    },
    {
      userarn  = "arn:aws:iam::870065213604:user/ariel.weinberger"
      username = "ariel.weinberger"
      groups   = ["system:masters"]
    }
  ]
}

data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_id
}

module "eks_external_dns" {
  depends_on = [module.eks.cluster_id]

  source  = "git::https://github.com/codingly-io/terraform-aws-eks-external-dns.git"

  helm_chart_version = "5.5.0"

  cluster_identity_oidc_issuer = module.eks.cluster_oidc_issuer_url
  cluster_identity_oidc_issuer_arn = module.eks.oidc_provider_arn
  cluster_name = local.cluster_name

  settings = {
    policy = "sync"
    interval = "20s"
    zoneIdFilters = "{${join(",", var.external_dns_zone_id_filters)}}"
  }
}

module "alb_ingress" {
  depends_on = [module.eks.cluster_endpoint]

  source = "../alb-ingress"

  region           = "eu-west-1"
  cluster_name     = local.cluster_name
  worker_role_name = module.eks.worker_iam_role_name
}

resource "helm_release" "prometheus" {
  depends_on = [module.eks.cluster_id]

  name       = "prometheus"
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "kube-prometheus-stack"
  namespace  = "default"
}

resource "helm_release" "metrics_server" {
  depends_on = [module.eks.cluster_id]

  name       = "metrics-server"
  repository = "https://kubernetes-sigs.github.io/metrics-server"
  chart      = "metrics-server"
  namespace  = "default"
}