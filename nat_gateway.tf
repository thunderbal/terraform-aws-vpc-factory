# nat_gateway.tf

resource "aws_nat_gateway" "self" {
  for_each      = local.nat_gateways
  subnet_id     = aws_subnet.self[each.value].id
  allocation_id = aws_eip.self[each.value].id

  depends_on = [aws_internet_gateway.self]
}
