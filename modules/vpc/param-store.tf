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