output "vpc_id" {
  value = aws_vpc.this.id
}
output "public_subnet_ids" {
  value = values(aws_subnet.public)[*].id
}
output "app_subnet_ids" {
  value = values(aws_subnet.app)[*].id
}
output "data_subnet_ids" {
  value = values(aws_subnet.data)[*].id
}
output "nat_gateway_ids" {
  value = values(aws_nat_gateway.this)[*].id
}
output "public_route_table_id" {
  value = aws_route_table.public.id
}
output "private_route_table_ids" {
  value = values(aws_route_table.private)[*].id
}