variable "vpc_name" {
  description = "Name of the VPC"
}

variable "vpc_details" {
  description = "Vpc details"
  type = object({
    cidr = string
    public_subnets = list(string)
    private_subnets = list(string)
    database_subnets = list(string)
  })
}
variable "tags" {
  type = map(string)
}
