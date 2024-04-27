# main.tf

data "aws_availability_zones" "current" {
  state = "available"
}

locals {
  availability_zones = var.availability_zones == null ? data.aws_availability_zones.current.names : var.availability_zones

  # subnets
  subnet_newbits = ceil(log(length(local.availability_zones), 2))
  subnets_attributes = merge(flatten([
    for k, v in var.subnet_groups : [
      for i, z in local.availability_zones : {
        join("-", [k, z]) = {
          availability_zone = z
          subnet_group      = k
          default_route     = v.default_route
          cidr_block        = cidrsubnet(v.cidr_block, local.subnet_newbits, i)
        }
      }
    ]
  ])...)

  # internet gateway
  internet_gateway_enabled = contains([for g in local.subnets_attributes : g.default_route == "internet_gateway"], true)

  # NAT gateways
  nat_subnet_groups = distinct([for k, v in var.subnet_groups : trimprefix(v.default_route, "nat_gateway.") if startswith(v.default_route, "nat_gateway")])
  nat_gateways = toset(flatten([
    for k in local.nat_subnet_groups : [
      for i, z in local.availability_zones : join("-", [k, z])
    ]
  ]))
}
