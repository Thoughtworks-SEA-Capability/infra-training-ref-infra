environment = "dev"

team_name = "merlion"

app_vpc = {
  cidr = "10.0.0.0/16"
  public_subnets = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
  private_subnets = [
    # Private subnets for EKS Control Plane
    "10.0.104.0/24","10.0.105.0/24","10.0.106.0/24",
    # Private subnets for EKS Nodes
    "10.0.108.0/23", "10.0.110.0/23","10.0.112.0/23"
  ]
  database_subnets = ["10.0.114.0/26", "10.0.114.64/26","10.0.114.128/26"]
}