module "app_eks" {
  source = "../../modules/eks"

  eks_cluster_name   = local.name
  eks_version        = "1.22"
  vpc_id             = module.app_vpc.vpc_id
  eks_master_subnets = module.app_vpc.eks_master_subnets
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
