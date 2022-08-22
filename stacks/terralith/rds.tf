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
  eks_security_group_ids = [module.app_eks.cluster_primary_security_group_id]
  tags = local.tags
}

// This secret name is sort of like config store for infra to pass on data to the application layer
// The name is agreed on by convention, changing the name will break the test and whatever subsequent application
resource "kubernetes_secret_v1" "app-a-rds-creds" {
  metadata {
    name = "app-a-db"
    namespace = var.application-ns-name
  }
  data = {
    db_name = module.app_aurora_db.cluster_database_name,
    db_endpoint = module.app_aurora_db.cluster_endpoint,
    db_username = module.app_aurora_db.cluster_master_username,
    db_password = module.app_aurora_db.cluster_master_password,
  }
}

data "aws_ssm_parameter" "vpc_id" {
  name = "${local.name}-vpc-id"
}

data "aws_ssm_parameter" "database_subnets" {
  name = "${local.name}-db"
}

data "aws_ssm_parameter" "database_subnet_group_name" {
  name  = "${local.name}-db-sg-name"
}


