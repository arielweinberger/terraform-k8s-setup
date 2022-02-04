# resource "helm_release" "aws_alb_ingress_controller" {
#   depends_on = [aws_iam_role_policy_attachment.aws_load_balancer_policy_attachment]

#   name       = "aws-alb-ingress-controller"
#   repository = "https://aws.github.io/eks-charts"
#   chart      = "aws-load-balancer-controller"
#   namespace  = "kube-system"

#   set {
#     name = "clusterName"
#     value = var.cluster_name
#   }

#   set {
#     name = "serviceAccount.create"
#     value = true
#   }

#   set {
#     name = "serviceAccount.name"
#     value = "aws-load-balancer-controller"
#   }
# }

module "alb_ingress_controller" {  
  source  = "iplabs/alb-ingress-controller/kubernetes"
  k8s_cluster_type = "eks"
  k8s_namespace    = "kube-system"
  aws_region_name  = var.region
  k8s_cluster_name = var.cluster_name
}