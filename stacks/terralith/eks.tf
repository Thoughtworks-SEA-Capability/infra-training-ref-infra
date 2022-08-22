module "app_eks" {
  source = "../../modules/eks"

  eks_cluster_name   = local.name
  eks_version        = "1.22"
  vpc_id             = data.aws_ssm_parameter.vpc_id.value
  eks_master_subnets = slice(split(",", data.aws_ssm_parameter.private_subnets.value), 0,3)
  tags               = local.tags
}

resource "kubernetes_namespace_v1" "application" {
  metadata {
    labels = merge(local.tags, {
      owner = "terraform"
    })
    name = var.application-ns-name
  }
}

data "aws_ssm_parameter" "private_subnets" {
  name = "${local.name}-private"
}