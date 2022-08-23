locals {
  db_name = "${local.name}-app-a-db"
}

module "app_aurora_db" {
  source = "../../modules/rds"

  db_name = local.db_name
  instance_class = "db.t3.medium"
  vpc_id = data.aws_ssm_parameter.vpc_id.value
  database_subnet_group_name = data.aws_ssm_parameter.database_subnet_group_name.value
  database_subnets = split(",", data.aws_ssm_parameter.database_subnets.value)
  eks_security_group_ids = [data.aws_ssm_parameter.eks_cluster_primary_sg_id.value]
  tags = local.tags
}


