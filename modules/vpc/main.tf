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

resource "aws_ssm_parameter" "private_subnets" {
  name  = "${var.vpc_name}-private"
  type  = "StringList"
  value = join(",", module.vpc.private_subnets)
}

resource "aws_ssm_parameter" "database_subnets" {
  name  = "${var.vpc_name}-db"
  type  = "StringList"
  value = join(",", module.vpc.database_subnets)
}

resource "aws_ssm_parameter" "database_subnet_group_name" {
  name  = "${var.vpc_name}-db-sg-name"
  type  = "String"
  value = module.vpc.database_subnet_group_name
}

resource "aws_ssm_parameter" "vpc_id" {
  name  = "${var.vpc_name}-vpc-id"
  type  = "String"
  value = module.vpc.vpc_id
}
