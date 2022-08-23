output "cluster_name" {
  value = local.name
}
output "cluster_admin_role_arn" {
  value = module.app_eks.cluster_admin_role_arn
}