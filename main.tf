terraform {
  required_version = ">=1.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">=4.0"
    }
  }
}

data "aws_availability_zones" "current" {
  state = "available"
}

resource "aws_vpc" "self" {
  cidr_block = var.cidr_block
}

resource "aws_default_route_table" "self" {
  default_route_table_id = aws_vpc.self.default_route_table_id

  route = []
}

resource "aws_default_network_acl" "self" {
  default_network_acl_id = aws_vpc.self.default_network_acl_id
}

resource "aws_default_security_group" "self" {
  vpc_id = aws_vpc.self.id
}

resource "aws_default_vpc_dhcp_options" "default" {
  lifecycle {
    ignore_changes = [tags_all]
  }
}

resource "aws_subnet" "public" {
  for_each = var.public_subnets

  vpc_id = aws_vpc.self.id
}
