# VPC
output "vpc_id" {
  value = module.vpc.vpc_id
}
output "public_subnet_ids" {
  value = module.vpc.public_subnet_ids
}
output "app_subnet_ids" {
  value = module.vpc.app_subnet_ids
}
output "data_subnet_ids" {
  value = module.vpc.data_subnet_ids
}
output "nat_gateway_ids" {
  value = module.vpc.nat_gateway_ids
}
output "public_route_table_id" {
  value = module.vpc.public_route_table_id
}
output "private_route_table_ids" {
  value = module.vpc.private_route_table_ids
}

# Security Group
output "alb_sg_id" {
  value = module.security_groups.alb_sg_id
}

output "ssh_sg_id" {
  value = module.security_groups.ssh_sg_id
}

output "web_sg_id" {
  value = module.security_groups.web_sg_id
}

output "db_sg_id" {
  value = module.security_groups.db_sg_id
}

output "efs_sg_id" {
  value = module.security_groups.efs_sg_id
}

# RDS
output "rds_endpoint" {
  value = module.rds.address
}

output "rds_port" {
  value = module.rds.port
}

# EFS
output "efs_id" {
  value = module.efs.efs_id
}

output "efs_mount_target_ids" {
  value = module.efs.mount_target_ids
}
