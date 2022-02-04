locals {
  cluster_name = "${var.cluster_name}-${random_string.suffix.result}"
}