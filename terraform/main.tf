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

# RDS
module "rds" {
  source            = "../modules/rds"
  vpc_id            = module.vpc.vpc_id
  subnet_ids        = module.vpc.data_subnet_ids
  security_group_id = module.security_groups.db_sg_id
  username          = var.db_user
  password          = var.db_password
  availability_zone = var.db_az
}

# EFS
module "efs" {
  source            = "../modules/efs"
  vpc_id            = module.vpc.vpc_id
  subnet_ids        = module.vpc.data_subnet_ids
  security_group_id = module.security_groups.efs_sg_id
}

# EC2
# Setup instance
module "setup_instance" {
  source             = "../modules/ec2"
  ami_id            = "ami-0dfe0f1abee59c78d"
  instance_type      = "t2.micro"
  key_name           = "wordpress"
  subnet_id          = module.vpc.public_subnet_ids[0] # public-a
  security_group_ids = [
    module.security_groups.ssh_sg_id,
    module.security_groups.alb_sg_id,
    module.security_groups.web_sg_id
  ]
  efs_mount_dns      = module.efs.efs_id
  db_endpoint        = module.rds.address
  db_name            = var.db_name
  db_user            = var.db_username
  db_password        = var.db_password
  region             = var.region
}

module "webserver_a" {
  source            = "../modules/webserver"
  ami_id            = "ami-0dfe0f1abee59c78d"
  instance_type     = "t2.micro"
  key_name          = "wordpress"
  subnet_id         = module.vpc.app_subnet_ids[0]
  subnet_name       = "a"
  security_group_id = module.security_groups.web_sg_id
  efs_mount_dns     = module.efs.efs_id
  region            = var.region
}

# Instantiate Webserver B (subnet app-b)
module "webserver_b" {
  source            = "../modules/webserver"
  ami_id            = "ami-0dfe0f1abee59c78d"
  instance_type     = "t2.micro"
  key_name          = "wordpress"
  subnet_id         = module.vpc.app_subnet_ids[1]
  subnet_name       = "b"
  security_group_id = module.security_groups.web_sg_id
  efs_mount_dns     = module.efs.efs_id
  region            = var.region
}