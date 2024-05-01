# main.tf

data "aws_availability_zones" "current" {
  state = "available"
}

locals {
  # Configure defaults when attributes are not defined
  prefix_name = var.prefix_name != null ? var.prefix_name : basename(path.cwd)
  cidr_block  = var.cidr_block != null ? var.cidr_block : "10.0.0.0/16"
  azs         = var.availability_zones != null ? var.availability_zones : slice(data.aws_availability_zones.current.names, 0, 2)

  nets = var.subnet_groups != null ? var.subnet_groups : {
    public = {
      cidr_block    = cidrsubnet(local.cidr_block, 1, 0)
      default_route = "igw"
    }
    private = {
      cidr_block    = cidrsubnet(local.cidr_block, 1, 1)
      default_route = "ngw/public"
    }
  }

  # subnets
  subnet_newbits = ceil(log(length(local.azs), 2))

  subnets_attributes = merge(flatten([
    for k, v in local.nets : [
      for i, z in local.azs : {
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
  igw_enabled = contains([for g in local.nets : g.default_route == "igw"], true)

  # NAT gateways
  nat_subnet_groups = distinct([for k, v in local.nets : basename(v.default_route) if startswith(v.default_route, "ngw/")])
  nat_gateways = toset(flatten([
    for k in local.nat_subnet_groups : [
      for i, z in local.azs : join("-", [k, z])
    ]
  ]))
}
