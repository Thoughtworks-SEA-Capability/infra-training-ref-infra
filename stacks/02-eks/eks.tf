module "app_eks" {
  source = "../../modules/eks"

  eks_cluster_name   = local.name
  eks_version        = "1.22"
  vpc_id             = data.aws_ssm_parameter.vpc_id.value
  eks_master_subnets = slice(split(",", data.aws_ssm_parameter.private_subnets.value), 0,3)
  tags               = local.tags
}

data "aws_ssm_parameter" "private_subnets" {
  name = "${local.name}-private"
}

data "aws_ssm_parameter" "vpc_id" {
  name = "${local.name}-vpc-id"
}