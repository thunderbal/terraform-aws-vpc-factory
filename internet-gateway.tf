# internet-gateway.tf

resource "aws_internet_gateway" "self" {
  count  = local.internet_gateway_enabled ? 1 : 0
  vpc_id = aws_vpc.self.id

  tags = {
    Name = join("-", compact([var.prefix, "igw"]))
  }
}
