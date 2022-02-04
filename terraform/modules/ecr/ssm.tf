resource "aws_ssm_parameter" "ecr_repository_url" {
  name = "/${var.stage}/ecr_repository_url"
  type = "String"
  value = aws_ecr_repository.ecr_repo.repository_url
  overwrite = true
}