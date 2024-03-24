# subnets.tf

resource "aws_subnet" "self" {
  for_each          = local.subnets_attributes
  vpc_id            = aws_vpc.self.id
  cidr_block        = each.value.cidr_block
  availability_zone = each.value.availability_zone

  tags = {
    Name = join("-", compact([var.prefix, each.key]))
  }
}

resource "aws_internet_gateway" "self" {
  count  = local.public_enabled ? 1 : 0
  vpc_id = aws_vpc.self.id

  tags = {
    Name = join("-", compact([var.prefix, "gw"]))
  }
}

resource "aws_route_table" "public" {
  count  = local.public_enabled ? 1 : 0
  vpc_id = aws_vpc.self.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.self[0].id
  }

  tags = {
    Name = join("-", compact([var.prefix, "public"]))
  }
}

resource "aws_route_table_association" "public" {
  for_each       = toset([for k, v in local.subnets_attributes : k if v.public])
  route_table_id = aws_route_table.public[0].id
  subnet_id      = aws_subnet.self[each.value].id
}
