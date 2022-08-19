terraform {
  backend "s3" {
    region = "ap-southeast-1"
    bucket = "infra-training-state-2022"
    key = "merlion/dev/terralith"
  }
}

provider "aws" {
  region = "ap-southeast-1"
}
