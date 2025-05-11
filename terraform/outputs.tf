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