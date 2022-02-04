data "aws_iam_policy" "aws_load_balancer_controller_policy" {
  name = "AWSLoadBalancerControllerIAMPolicy"
}

resource "aws_iam_role_policy_attachment" "aws_load_balancer_policy_attachment" {
  role       = var.worker_role_name
  policy_arn = data.aws_iam_policy.aws_load_balancer_controller_policy.arn
}