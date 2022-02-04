locals {
  env = {
    defaults = {
      aws_account_id = "870065213604"

      app_app_zone_id             = "XXX"
      app_app_certificate_arn     = "XXX"
      dev_app_app_zone_id         = "XXX"
      dev_app_app_certificate_arn = "XXX"

      app_api_zone_id             = "XXX"
      app_api_certificate_arn     = "XXX"
      dev_app_api_zone_id         = "XXX"
      dev_app_api_certificate_arn = "XXX"

      internal_app_app_zone_id         = "XXX"
      internal_app_api_certificate_arn = "XXX"
    }

    dev = {
      stage = "dev"
      external_dns_zone_id_filters = [
        "XXX",
        "XXX"
      ],
      eks_instance_type    = "t2.medium",
      eks_desired_capacity = 2
    }

    prod = {
      stage = "prod"
      external_dns_zone_id_filters = [
        "XXX",
        "XXX",
        "XXX"
      ],
      eks_instance_type    = "t2.large",
      eks_desired_capacity = 3
    }
  }

  workspace = merge(local.env["defaults"], local.env[terraform.workspace])
}
