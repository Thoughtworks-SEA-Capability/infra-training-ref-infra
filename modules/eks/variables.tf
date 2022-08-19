variable "eks_cluster_name" {
  description = "Name of the eks cluster"
}

variable "eks_version" {
  description = "Version of the eks"
}

variable "vpc_id" {
  default = "VPC id in which eks needs to be provisioned"
}

variable "eks_master_subnets" {
  description = "EKS master subnets id"
}

variable "tags" {
  description = "Tags for eks"
  type = map(string)
}
