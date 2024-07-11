# main.tf

provider "aws" {
  default_tags {
    tags = {
      Project = "ex-${basename(path.cwd)}"
      Iac     = "terraform"
    }
  }
}

module "vpc" {
  source      = "../.."
  config_file = "./custom.yml"
}
