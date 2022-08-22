locals {
  stack       = "terralith"
  name        = "${var.team_name}-${var.environment}-${local.stack}"
  tags = {
    team        = var.team_name
    stack       = local.stack
    environment = var.environment
  }
}