terraform {
  backend "s3" {
    region = "ap-southeast-1"
    bucket = "infra-training-state-2022"
    key = "merlion/dev/00-network.json"
  }
}

provider "aws" {
  region = "ap-southeast-1"
}
