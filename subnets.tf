# subnets.tf

resource "aws_subnet" "self" {
  for_each          = local.subnets_attributes
  vpc_id            = aws_vpc.self.id
  cidr_block        = each.value.cidr_block
  availability_zone = each.value.availability_zone

  tags = merge(each.value.tags, {
    Name = join("-", compact([local.prefix_name, each.key]))
  })
}

resource "aws_eip" "self" {
  for_each = local.nat_gateways
  domain   = "vpc"
}
