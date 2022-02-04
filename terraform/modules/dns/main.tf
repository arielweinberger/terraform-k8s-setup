data "aws_route53_zone" "main" {
  zone_id = var.parent_hosted_zone_id
}

resource "aws_route53_zone" "env_specific" {
  name = var.hosted_zone_name
}

resource "aws_route53_record" "env_record_ns" {
  depends_on = [
    aws_route53_zone.env_specific
  ]

  zone_id = var.parent_hosted_zone_id
  name    = aws_route53_zone.env_specific.name
  type    = "NS"
  ttl     = "3600"
  records = aws_route53_zone.env_specific.name_servers
}