data "aws_availability_zones" "azs" {
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.14.2"

  name = var.vpc_name
  cidr = var.vpc_cidr
  tags = merge(var.tags, {
    Name = var.vpc_name
  })

  azs            = data.aws_availability_zones.azs.names
  public_subnets = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
  public_subnet_tags = merge(var.tags, {
    Name = "${var.vpc_name}-public"
    type = "public"
  })

  private_subnets = [
    # Private subnets for EKS Control Plane
    "10.0.104.0/24","10.0.105.0/24","10.0.106.0/24",
    # Private subnets for EKS Nodes
    "10.0.108.0/23", "10.0.110.0/23","10.0.112.0/23",
  ]
  private_subnet_tags = merge(var.tags, {
    Name = "${var.vpc_name}-private"
    type = "private"
  })

  database_subnets = [
    # Private subnets for EKS Nodes
    "10.0.114.0/26", "10.0.114.64/26","10.0.114.128/26",
  ]
  database_subnet_tags = merge(var.tags, {
    Name = "${var.vpc_name}-db"
    type = "db"
  })


  # One NAT per Az
  enable_nat_gateway = true
  single_nat_gateway = false
  one_nat_gateway_per_az = true
}