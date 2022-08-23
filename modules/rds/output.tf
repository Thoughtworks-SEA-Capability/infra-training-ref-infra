output "cluster_database_name" {
  value = module.rds_aurora.cluster_database_name
}

output "cluster_endpoint" {
  value = module.rds_aurora.cluster_endpoint
}

output "cluster_master_username" {
  value = module.rds_aurora.cluster_master_username
}

output "cluster_master_password" {
  value = module.rds_aurora.cluster_master_password
}