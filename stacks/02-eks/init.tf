terraform {
  backend "s3" {
    region = "ap-southeast-1"
    bucket = "infra-training-state-2022"
    key = "merlion/dev/02-eks.json"
  }
}

provider "aws" {
  region = "ap-southeast-1"
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.default.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.default.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.default.token
}