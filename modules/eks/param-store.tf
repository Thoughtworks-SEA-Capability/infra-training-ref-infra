resource "aws_ssm_parameter" "eks_cluster_id" {
  name  = "${var.eks_cluster_name}-eks-cluster-id"
  type  = "String"
  value = module.eks.cluster_id
}

resource "aws_ssm_parameter" "eks_cluster_primary_sg_id" {
  name  = "${var.eks_cluster_name}-eks-cluster-sg-id"
  type  = "String"
  value = module.eks.cluster_primary_security_group_id
}