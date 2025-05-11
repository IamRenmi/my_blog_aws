# VPC
resource "aws_vpc" "this" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  instance_tenancy     = "default"

  tags = { Name = "wordpress-vpc" }
}

# subnets
resource "aws_subnet" "public" {
  for_each = var.public_subnets

  vpc_id                  = aws_vpc.this.id
  cidr_block              = each.value
  availability_zone       = var.subnet_azs[each.key]
  map_public_ip_on_launch = true
  tags                    = { Name = each.key }
}
resource "aws_subnet" "app" {
  for_each = var.app_subnets

  vpc_id            = aws_vpc.this.id
  cidr_block        = each.value
  availability_zone = var.subnet_azs[each.key]
  tags              = { Name = each.key }
}
resource "aws_subnet" "data" {
  for_each = var.data_subnets

  vpc_id            = aws_vpc.this.id
  cidr_block        = each.value
  availability_zone = var.subnet_azs[each.key]
  tags              = { Name = each.key }
}

# Internet Gateway
resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id
  tags   = { Name = "wordpress-igw" }
}

# NAT Gateway & elastic IP
resource "aws_eip" "nat" {
  for_each = var.public_subnets
  tags     = { Name = replace(each.key, "public", "nat-gw") }
}
resource "aws_nat_gateway" "this" {
  for_each      = var.public_subnets
  allocation_id = aws_eip.nat[each.key].id
  subnet_id     = aws_subnet.public[each.key].id
  tags          = { Name = replace(each.key, "public", "nat-gw") }
}

#  Route Tables
## Public RT
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id
  tags   = { Name = "public-rtb" }
}
resource "aws_route" "public_default" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.this.id
}
resource "aws_route_table_association" "public" {
  for_each       = aws_subnet.public
  subnet_id      = each.value.id
  route_table_id = aws_route_table.public.id
}

## Private RT (per AZ)
resource "aws_route_table" "private" {
  for_each = aws_nat_gateway.this
  vpc_id   = aws_vpc.this.id
  tags     = { Name = "private-rtb-${split("-", each.key)[1]}" }
}
resource "aws_route" "private_default" {
  for_each              = aws_route_table.private
  route_table_id        = each.value.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id        = aws_nat_gateway.this[each.key].id
}
resource "aws_route_table_association" "app" {
  for_each       = aws_route_table.private
  subnet_id      = aws_subnet.app["app-${split("-", each.key)[1]}"] .id
  route_table_id = each.value.id
}
resource "aws_route_table_association" "data" {
  for_each       = aws_route_table.private
  subnet_id      = aws_subnet.data["data-${split("-", each.key)[1]}"] .id
  route_table_id = each.value.id
}