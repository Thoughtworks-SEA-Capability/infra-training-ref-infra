data "aws_availability_zones" "azs" {
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.14.2"

  name = var.vpc_name
  cidr = var.vpc_details.cidr
  tags = merge(var.tags, {
    Name = var.vpc_name
  })

  azs            = data.aws_availability_zones.azs.names
  public_subnets = var.vpc_details.public_subnets
  public_subnet_tags = merge(var.tags, {
    Name = "${var.vpc_name}-public"
    type = "public"
  })

  private_subnets = var.vpc_details.private_subnets
  private_subnet_tags = merge(var.tags, {
    Name = "${var.vpc_name}-private"
    type = "private"
  })

  database_subnets = var.vpc_details.database_subnets
  database_subnet_tags = merge(var.tags, {
    Name = "${var.vpc_name}-db"
    type = "db"
  })

  # One NAT per Az
  enable_nat_gateway = true
  single_nat_gateway = false
  one_nat_gateway_per_az = true
}