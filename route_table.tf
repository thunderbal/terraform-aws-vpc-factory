# route_table.tf

resource "aws_route_table" "self" {
  for_each = local.subnets_attributes
  vpc_id   = aws_vpc.self.id

  dynamic "route" {
    for_each = each.value.default_route == "igw" ? toset([0]) : []
    content {
      cidr_block = "0.0.0.0/0"
      gateway_id = aws_internet_gateway.self[route.value].id
    }
  }

  dynamic "route" {
    for_each = startswith(each.value.default_route, "ngw/") ? toset([basename(each.value.default_route)]) : []
    content {
      cidr_block     = "0.0.0.0/0"
      nat_gateway_id = aws_nat_gateway.self[join("-", [route.value, each.value.availability_zone])].id
    }
  }

  tags = {
    Name = join("-", compact([local.prefix_name, each.key]))
  }
}

resource "aws_route_table_association" "public" {
  for_each       = local.subnets_attributes
  route_table_id = aws_route_table.self[each.key].id
  subnet_id      = aws_subnet.self[each.key].id
}
