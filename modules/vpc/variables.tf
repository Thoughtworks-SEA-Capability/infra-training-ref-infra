variable "vpc_name" {
  description = "Name of the VPC"
}

variable "vpc_cidr" {
  description = "CIDR range of vpc"
}

variable "tags" {
  type = map(string)
}
