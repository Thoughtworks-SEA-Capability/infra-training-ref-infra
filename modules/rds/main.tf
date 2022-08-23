module "rds_aurora" {
  source  = "terraform-aws-modules/rds-aurora/aws"
  version = "7.2.1"

  name           = var.db_name
  engine         = "aurora-postgresql"
  engine_version = "11.12"
  instance_class = var.instance_class
  instances = {
    one = {}
  }

  vpc_id  = var.vpc_id
  create_db_subnet_group = false
  db_subnet_group_name = var.database_subnet_group_name
  subnets = var.database_subnets

  allowed_security_groups = var.eks_security_group_ids
  allowed_cidr_blocks     = ["10.0.0.0/20"]

  storage_encrypted   = true
  apply_immediately   = true
  monitoring_interval = 10

  db_parameter_group_name         = aws_db_parameter_group.db.name
  db_cluster_parameter_group_name = aws_rds_cluster_parameter_group.db.name

  enabled_cloudwatch_logs_exports = ["postgresql"]

  tags = merge(var.tags,{
    Name = var.db_name
  } )
}

resource "aws_db_parameter_group" "db" {
  name = var.db_name
  family = "aurora-postgresql11"
  tags = merge(var.tags, {
    Name: var.db_name
  })
}

resource "aws_rds_cluster_parameter_group" "db" {
  name = var.db_name
  family = "aurora-postgresql11"
  tags = merge(var.tags, {
    Name: var.db_name
  })
}