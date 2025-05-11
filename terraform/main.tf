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

# VPC
module "vpc" {
  source         = "../modules/vpc"
  region         = var.region
  vpc_cidr       = var.vpc_cidr
  public_subnets = var.public_subnets
  app_subnets    = var.app_subnets
  data_subnets   = var.data_subnets
  subnet_azs     = var.subnet_azs
}

# Security Groups
module "security_groups" {
  source          = "../modules/sg"
  vpc_id          = module.vpc.vpc_id
  ssh_source_cidr = var.ssh_allowed_cidr
  tags            = local.common_tags
}