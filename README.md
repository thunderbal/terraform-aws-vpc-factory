# Terraform module - VPC Factory

Terraform VPC factory module creates a VPC with as many subnet tiers as described in subnet_groups attribute.
For each subnet tier, a subnet is created in each selectec availability zones in availability_zones attribute.
If these attributes are not specified, 2 tiers are creates : public and private in the 2 first availability
zones of the current AWS region.An Internet Gateway is configured as default route for public tier's subnets
and a NAT Gateway in each public subnets is created and configured as default route for private tier's subnets.

The default CIDR block for VPC is 10.0.0.0/16, but it can be customized with cidr_block.

By default, Network ACLs are configured to allow all ingress/egress.

## Usage

```
# Defaults
module "network" {
  source = "git:https://github.com/thunderbal/terraform-aws-vpc-factory?ref=main"
}


# Custom example
module "network" {
  source = "git:https://github.com/thunderbal/terraform-aws-vpc-factory?ref=main"

  prefix_name          = "example"
  cidr_block           = "10.0.0.0/16"
  availability_zones   = ["eu-west-1a", "eu-west-1b"]
  network_acl_disabled = true

  subnet_groups = {
    dmz = {
      default_route = "igw"
      cidr_block    = "10.0.0.0/26"
    }
    frontend = {
      default_route = "ngw/pub"
      cidr_block = "10.0.16.0/20"
    }
    backend = {
      cidr_block = "10.0.32.0/20"
    }
  }
}
```

By default, Network ACLs allow alltrafic. Set __network_acl_disabled__ to __false__ to block all trafic by default.

__prefix_name__ is used in tag Name to identify resources created by this module.

If __availability_zones__ is not specified, module use 2 availability zones in the target region.

All subnet_groups must be given a __cidr_block__ within __cidr_bloc__ (default 10.0.0.0/16) provided
to the module. Each block which wil be cut into several sub-blocks to have a subnet per availability
zone for each groups. Group's __cidr_block__ must not overlap each others .

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >=1.3.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >=4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.57.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_default_network_acl.self](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/default_network_acl) | resource |
| [aws_default_route_table.self](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/default_route_table) | resource |
| [aws_default_security_group.self](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/default_security_group) | resource |
| [aws_default_vpc_dhcp_options.self](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/default_vpc_dhcp_options) | resource |
| [aws_eip.self](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip) | resource |
| [aws_internet_gateway.self](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway) | resource |
| [aws_nat_gateway.self](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/nat_gateway) | resource |
| [aws_network_acl_rule.all_egress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_acl_rule) | resource |
| [aws_network_acl_rule.all_ingress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_acl_rule) | resource |
| [aws_route_table.self](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table_association.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_subnet.self](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_vpc.self](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc) | resource |
| [aws_availability_zones.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_config_file"></a> [config\_file](#input\_config\_file) | Network configuration file. | `string` | `null` | no |
| <a name="input_config_template"></a> [config\_template](#input\_config\_template) | value | `string` | `"default"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aws_availability_zones"></a> [aws\_availability\_zones](#output\_aws\_availability\_zones) | List of available AZ names. |
| <a name="output_subnet_ids"></a> [subnet\_ids](#output\_subnet\_ids) | Map of public subnet IDs. |
| <a name="output_vpc"></a> [vpc](#output\_vpc) | value |
<!-- END_TF_DOCS -->
