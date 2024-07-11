# main.tf

data "aws_availability_zones" "current" {
  state = "available"
}

locals {
  config_file = var.config_file == null ? "${path.module}/config/${var.config_template}.yaml" : var.config_file
  config      = yamldecode(file(local.config_file))

  # Configure defaults when attributes are not defined
  prefix_name   = try(local.config.prefix_name, basename(path.cwd))
  cidr_block    = try(local.config.cidr_block, "10.0.0.0/16")
  azs_count     = min(try(local.config.max_azs, 2), length(data.aws_availability_zones.current.names))
  azs           = try(local.config.availability_zones, slice(data.aws_availability_zones.current.names, 0, local.azs_count))
  nacl_disabled = try(local.config.nacl_disabled, false)
  nets          = try(local.config.subnet_groups, {})

  # subnets
  nets_newbits = ceil(log(length(local.nets), 2))
  azs_newbits  = ceil(log(length(local.azs), 2))

  net_cidr_blocks = {
    for i, v in keys(local.nets) : v => try(local.nets[v].cidr_block, cidrsubnet(local.cidr_block, local.nets_newbits, i))
  }

  subnets_attributes = merge(flatten([
    for k, v in local.nets : [
      for i, z in local.azs : {
        join("-", [k, z]) = {
          availability_zone = z
          subnet_group      = k
          default_route     = try(v.default_route, "")
          cidr_block        = cidrsubnet(local.net_cidr_blocks[k], local.azs_newbits, i)
          tags              = try(v.tags, { test : "none" })
        }
      }
    ]
  ])...)

  # internet gateway
  igw_enabled = contains([for g in local.nets : try(g.default_route == "igw", false)], true)

  # NAT gateways
  nat_subnet_groups = distinct([for g in local.nets : basename(g.default_route) if try(startswith(g.default_route, "ngw/"), false)])
  nat_gateways = toset(flatten([
    for k in local.nat_subnet_groups : [
      for i, z in local.azs : join("-", [k, z])
    ]
  ]))
}
