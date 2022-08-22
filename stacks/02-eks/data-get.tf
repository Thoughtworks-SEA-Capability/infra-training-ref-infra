data "aws_ssm_parameter" "private_subnets" {
  name = "${local.name}-private"
}

data "aws_ssm_parameter" "vpc_id" {
  name = "${local.name}-vpc-id"
}

data "aws_eks_cluster" "default" {
  name = module.app_eks.cluster_id
}

data "aws_eks_cluster_auth" "default" {
  name = module.app_eks.cluster_id
}