data "aws_acm_certificate" "app_app" {
  domain = "*.codingly-app.com"
  types  = ["AMAZON_ISSUED"]
}

data "aws_acm_certificate" "dev_app_app" {
  domain = "*.dev.codingly-app.com"
  types  = ["AMAZON_ISSUED"]
}

data "aws_acm_certificate" "app_api" {
  domain = "*.codingly-api.com"
  types  = ["AMAZON_ISSUED"]
}

data "aws_acm_certificate" "dev_app_api" {
  domain = "*.dev.codingly-api.com"
  types  = ["AMAZON_ISSUED"]
}

data "aws_acm_certificate" "internal_app_app" {
  domain = "*.internal.codingly-app.com"
  types  = ["AMAZON_ISSUED"]
}