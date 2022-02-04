variable "region" {
  type = string
}

variable "cluster_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "external_dns_zone_id_filters" {
  type = list(string)
}

variable "instance_type" {
  type = string
}

variable "desired_capacity" {
  type = string
}