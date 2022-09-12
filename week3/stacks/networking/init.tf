terraform {
  backend "s3" {
    region = "ap-southeast-1"
    bucket = "infra-training-state-2022"
  }
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 4.27.0"
    }
  }
}

provider "aws" {
  region = "ap-southeast-1"
}
