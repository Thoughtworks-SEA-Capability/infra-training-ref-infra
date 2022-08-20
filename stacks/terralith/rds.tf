locals {
  db_name = "${local.name}-app-a-db"
}

module "app_aurora_db" {
  source = "../../modules/rds"

  db_name = local.db_name
  instance_class = "db.t3.medium"
  vpc_id = module.app_vpc.vpc_id
  database_subnet_group_name = module.app_vpc.database_subnet_group_name
  database_subnets = module.app_vpc.database_subnets
  eks_security_group_ids = [module.app_eks.cluster_primary_security_group_id]
  tags = local.tags
}

// This secret name is sort of like config store for infra to pass on data to the application layer
// The name is agreed on by convention, changing the name will break the test and whatever subsequent application
resource "kubernetes_secret_v1" "app-a-rds-creds" {
  metadata {
    name = "app-a-db"
    namespace = local.application-ns-name
  }
  data = {
    db_name = module.app_aurora_db.cluster_database_name,
    db_endpoint = module.app_aurora_db.cluster_endpoint,
    db_username = module.app_aurora_db.cluster_master_username,
    db_password = module.app_aurora_db.cluster_master_password,
  }
}
