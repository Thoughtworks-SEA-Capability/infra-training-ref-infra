locals {
  team        = var.team_name
  stack       = "terralith"
  environment = var.environment
  name        = "${local.team}-${local.environment}-${local.stack}"
  tags = {
    team        = local.team
    stack       = local.stack
    environment = local.environment
  }
}

module "app_vpc" {
  source = "../../modules/vpc"

  vpc_name = local.name
  vpc_cidr = "10.0.0.0/16"
  vpc_details = var.app_vpc

  tags = local.tags
}

locals {
  eks_master_subnets = module.app_vpc.eks_master_subnets
  eks_node_subnets = module.app_vpc.eks_node_subnets
}
