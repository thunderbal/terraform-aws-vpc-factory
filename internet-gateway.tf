# internet-gateway.tf

resource "aws_internet_gateway" "self" {
  count  = local.igw_enabled ? 1 : 0
  vpc_id = aws_vpc.self.id

  tags = {
    Name = join("-", compact([local.prefix_name, "igw"]))
  }
}
