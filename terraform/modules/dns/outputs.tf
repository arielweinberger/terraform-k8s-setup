output "parent_hosted_zone_id" {
  value = data.aws_route53_zone.main
}

output "created_hosted_zone_id" {
  value = aws_route53_zone.env_specific.zone_id
}