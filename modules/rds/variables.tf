variable "db_name" {
  description = "Name of the database"
}

variable "instance_class" {
  default = "Type of the instance class"
}

variable "vpc_id" {
  default = "VPC id in which rds needs to be provisioned"
}

variable "database_subnet_group_name" {
  description = "Database subnet group name"
}

variable "database_subnets" {
  description = "Database subnets id"
}

variable "eks_security_group_ids" {
  description = "Primary security group id of eks"
  type = list
}

variable "tags" {
  type = map(string)
}