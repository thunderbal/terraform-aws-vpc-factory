locals {
  name       = "ex-${basename(path.cwd)}"
  region     = "eu-west-1"
  cidr_block = "10.0.0.0/16"

  tags = {
    Example = local.name
    Repo    = "terraform-aws-vpc-factory"
    Org     = "terraform-modules"
  }
}

provider "aws" {
  region = local.region

  default_tags {
    tags = local.tags
  }
}

module "vpc" {
  source     = "../.."
  prefix     = local.name
  cidr_block = local.cidr_block
  subnet_groups = {
    public = {
      public     = true
      cidr_block = cidrsubnet(local.cidr_block, 1, 0)
    }
    private = {
      cidr_block = cidrsubnet(local.cidr_block, 1, 1)
    }
  }
}
