output "cluster_name" {
  value = var.eks_cluster_name
}

output "cluster_id" {
  value = module.eks.cluster_id
}

output "cluster_admin_role_arn" {
  value = aws_iam_role.eks-admin.arn
}

output "cluster_primary_security_group_id" {
  value = module.eks.cluster_primary_security_group_id
}