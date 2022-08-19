data "aws_eks_cluster" "default" {
  name = module.app_eks.cluster_id
}

data "aws_eks_cluster_auth" "default" {
  name = module.app_eks.cluster_id
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.default.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.default.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.default.token
}

locals {
  cluster_version = "1.22"
}

data "aws_caller_identity" "current" {}

################################################################################
# EKS Module
################################################################################
module "app_eks" {
  source = "../../modules/eks"

  eks_cluster_name   = local.name
  eks_version        = "1.22"
  vpc_id             = module.vpc.vpc_id
  eks_master_subnets = local.eks_master_subnets
  tags               = local.tags
}

moved {
  from = module.eks
  to = module.app_eks.module.eks
}

moved {
  from = module.vpc_cni_irsa
  to = module.app_eks.module.vpc_cni_irsa
}

moved {
  from = aws_iam_role_policy_attachment.additional
  to = module.app_eks.aws_iam_role_policy_attachment.additional
}

moved {
  from = aws_kms_key.eks
  to = module.app_eks.aws_kms_key.eks
}

moved {
  from = aws_iam_policy.node_additional
  to = module.app_eks.aws_iam_policy.node_additional
}

moved {
  from = aws_iam_role.eks-admin
  to = module.app_eks.aws_iam_role.eks-admin
}


// This namespace name is agreed by convention between the infra and app layers
// Changing the name will break the test and subsequently whatever application.
locals {
  application-ns-name = "application"
}
resource "kubernetes_namespace_v1" "application" {
  metadata {
    labels = merge(local.tags, {
      owner = "terraform"
    })
    name = local.application-ns-name
  }
}
