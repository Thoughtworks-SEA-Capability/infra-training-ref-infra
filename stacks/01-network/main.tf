locals {
  stack       = "terralith"
  name        = "${var.team_name}-${var.environment}-${local.stack}"
  tags = {
    team        = var.team_name
    stack       = local.stack
    environment = var.environment
  }
}

module "app_vpc" {
  source = "../../modules/vpc"

  vpc_name = local.name
  vpc_details = var.app_vpc

  tags = local.tags
}