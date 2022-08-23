resource "kubernetes_namespace_v1" "application" {
  metadata {
    labels = merge(local.tags, {
      owner = "terraform"
    })
    name = var.application-ns-name
  }
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
