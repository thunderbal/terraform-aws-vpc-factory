# main.tf

data "aws_availability_zones" "current" {
  state = "available"
}

locals {
  # global
  availability_zones = var.availability_zones == null ? data.aws_availability_zones.current.names : var.availability_zones

  # vpc
  vpc_name = join("-", compact([var.prefix, "vpc"]))

  # subnets
  subnet_newbits = ceil(log(length(local.availability_zones), 2))
  subnets_attributes = merge(flatten([
    for k, v in var.subnet_groups : [
      for i, z in local.availability_zones : {
        join("-", [k, z]) = {
          availability_zone = z
          subnet_group      = k
          public            = v.public
          cidr_block        = cidrsubnet(v.cidr_block, local.subnet_newbits, i)
        }
      }
    ]
  ])...)

  # internet gateway
  public_enabled = contains([for g in var.subnet_groups : g.public], true)
}
