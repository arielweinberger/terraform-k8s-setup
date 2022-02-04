# resource "aws_iam_policy" "external_dns_policy" {
#   name        = "AllowExternalDNSUpdates"
#   path        = "/"

#   # Terraform's "jsonencode" function converts a
#   # Terraform expression result to valid JSON syntax.
#   policy = jsonencode({
#     "Version" : "2012-10-17",
#     "Statement" : [
#       {
#         "Effect" : "Allow",
#         "Action" : [
#           "route53:ChangeResourceRecordSets"
#         ],
#         "Resource" : [
#           "arn:aws:route53:::hostedzone/*"
#         ]
#       },
#       {
#         "Effect" : "Allow",
#         "Action" : [
#           "route53:ListHostedZones",
#           "route53:ListResourceRecordSets"
#         ],
#         "Resource" : [
#           "*"
#         ]
#       }
#     ]
#   })
# }

# resource "aws_iam_role" "example" {
#   name                = "ExternalDNSRole"
#   managed_policy_arns = [aws_iam_policy.external_dns_policy.arn]
#   assume_role_policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Action = "sts:AssumeRole"
#         Effect = "Allow"
#         Sid    = ""
#         Principal = {
#           Service = "ec2.amazonaws.com"
#         }
#       },
#     ]
#   })
# }