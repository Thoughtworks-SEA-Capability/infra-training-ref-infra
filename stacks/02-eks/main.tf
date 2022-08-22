locals {
  stack       = "terralith"
  name        = "${var.team_name}-${var.environment}-${local.stack}"
  tags = {
    team        = var.team_name
    stack       = local.stack
    environment = var.environment
  }
}

module "app_eks" {
  source = "../../modules/eks"

  eks_cluster_name   = local.name
  eks_version        = "1.22"
  vpc_id             = data.aws_ssm_parameter.vpc_id.value
  eks_master_subnets = slice(split(",", data.aws_ssm_parameter.private_subnets.value), 0,3)
  tags               = local.tags
}