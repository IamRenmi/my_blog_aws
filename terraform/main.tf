provider "aws" {
  region = var.region
}

locals {
  common_tags = {
    Project     = "wordpress"
    Environment = var.environment
    Owner       = "renmi13@outlook.com"
  }
}

module "vpc" {
  source         = "../modules/vpc"
  region         = var.region
  vpc_cidr       = var.vpc_cidr
  public_subnets = var.public_subnets
  app_subnets    = var.app_subnets
  data_subnets   = var.data_subnets
  subnet_azs     = var.subnet_azs
}