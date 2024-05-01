# vpc.tf

resource "aws_vpc" "self" {
  cidr_block           = local.cidr_block
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = join("-", compact([local.prefix_name, "vpc"]))
  }
}

resource "aws_default_route_table" "self" {
  default_route_table_id = aws_vpc.self.default_route_table_id
  route                  = []

  tags = {
    Name = join("-", compact([local.prefix_name, "default"]))
  }
}

resource "aws_default_network_acl" "self" {
  default_network_acl_id = aws_vpc.self.default_network_acl_id

  tags = {
    Name = join("-", compact([local.prefix_name, "nacl"]))
  }

  lifecycle {
    ignore_changes = [subnet_ids, egress, ingress]
  }
}

resource "aws_network_acl_rule" "all_ingress" {
  count          = var.network_acl_disabled == true ? 1 : 0
  network_acl_id = aws_default_network_acl.self.id
  rule_number    = 100
  rule_action    = "allow"
  protocol       = -1
  egress         = false
  cidr_block     = "0.0.0.0/0"
}

resource "aws_network_acl_rule" "all_egress" {
  count          = var.network_acl_disabled ? 1 : 0
  network_acl_id = aws_default_network_acl.self.id
  rule_number    = 100
  rule_action    = "allow"
  protocol       = -1
  egress         = true
  cidr_block     = "0.0.0.0/0"
}

resource "aws_default_security_group" "self" {
  vpc_id = aws_vpc.self.id

  tags = {
    Name = join("-", compact([local.prefix_name, "default", "sg"]))
  }
}

resource "aws_default_vpc_dhcp_options" "self" {
  lifecycle {
    ignore_changes = [tags_all]
  }
}
