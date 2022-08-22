module "app_vpc" {
  source = "../../modules/vpc"

  vpc_name = local.name
  vpc_details = var.app_vpc

  tags = local.tags
}
