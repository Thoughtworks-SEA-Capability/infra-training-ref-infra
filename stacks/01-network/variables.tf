variable "environment" {
  description = "environment in which this stack is being currently deployed"
}

variable "team_name" {
  description = "name of the pair or individual owning this stack"
}

variable "app_vpc" {
  description = "Application vpc details"
  type = object({
    cidr = string
    public_subnets = list(string)
    private_subnets = list(string)
    database_subnets = list(string)
  })
}