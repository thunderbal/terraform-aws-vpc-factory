provider "aws" {
  region = local.region

  default_tags {
    tags = local.tags
  }
}

locals {
  name   = "ex-${basename(path.cwd)}"
  region = "eu-west-1"

  tags = {
    Example = local.name
    Repo    = "terraform-aws-vpc-factory"
    Org     = "terraform-modules"
  }
}

module "vpc" {
  source = "../.."
}
