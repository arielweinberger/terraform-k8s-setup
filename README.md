# WARNING: This is not production-ready. Use at your own risk. I am by no means a k8s expert :)

This is my setup for deploying a Kubernetes cluster to AWS. This includes:
* EKS
* ECR
* Aurora (optional)
* Route53
* SSM
* ALB Ingress Controller
* Prometheus + Grafana
* Istio

The setup enables multi-stage deployment into `development` and `production`.
You can configure stage parameters in `terraform/workspace.config.tf`