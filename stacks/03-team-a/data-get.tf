data "aws_ssm_parameter" "vpc_id" {
  name = "${local.name}-vpc-id"
}

data "aws_ssm_parameter" "database_subnets" {
  name = "${local.name}-db"
}

data "aws_ssm_parameter" "database_subnet_group_name" {
  name  = "${local.name}-db-sg-name"
}

data "aws_ssm_parameter" "eks_cluster_primary_sg_id" {
  name  = "${local.name}-eks-cluster-sg-id"
}

data "aws_ssm_parameter" "eks_cluster_id" {
  name  = "${local.name}-eks-cluster-id"
}

data "aws_eks_cluster" "default" {
  name = data.aws_ssm_parameter.eks_cluster_id.value
}

data "aws_eks_cluster_auth" "default" {
  name = data.aws_ssm_parameter.eks_cluster_id.value
}