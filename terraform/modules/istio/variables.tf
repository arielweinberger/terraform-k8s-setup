variable "kube_config_path" {
  description = "Path to the local kube config"
  type = string
  default = "~/.kube/config"
}

variable "eks_cluster_id" {
  type = string
}