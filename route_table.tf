# route_table.tf

resource "aws_route_table" "self" {
  for_each = local.subnets_attributes
  vpc_id   = aws_vpc.self.id

  dynamic "route" {
    for_each = each.value.default_route == "internet_gateway" ? toset([0]) : []
    content {
      cidr_block = "0.0.0.0/0"
      gateway_id = aws_internet_gateway.self[route.value].id
    }
  }

  dynamic "route" {
    for_each = startswith(each.value.default_route, "nat_gateway.") ? toset([trimprefix(each.value.default_route, "nat_gateway.")]) : []
    content {
      cidr_block     = "0.0.0.0/0"
      nat_gateway_id = aws_nat_gateway.self[join("-", [route.value, each.value.availability_zone])].id
    }
  }

  tags = {
    Name = join("-", compact([var.prefix, each.key]))
  }
}

resource "aws_route_table_association" "public" {
  for_each       = local.subnets_attributes
  route_table_id = aws_route_table.self[each.key].id
  subnet_id      = aws_subnet.self[each.key].id
}
