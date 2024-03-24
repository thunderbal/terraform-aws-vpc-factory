# Terraform module - VPC Factory

## Usage

```
module "network" {
  source = "git:https://gitea.fillon.info/terraform-modules/terraform-aws-vpc-factory?ref=main"

  prefix               = "example"
  cidr_block           = "10.0.0.0/16"
  availability_zones   = ["eu-west-1a", "eu-west-1b"]
  network_acl_disabled = true

  subnet_groups = {
    dmz = {
      public     = true
      cidr_block = "10.0.0.0/26"
    }
    frontend = {
      cidr_block = "10.0.16.0/20"
    }
    backend = {
      cidr_block = "10.0.32.0/20"
    }
  }
}
```

By default, Network ACLs allow alltrafic. Set __network_acl_disabled__ to __false__ to block all trafic by default.

__prefix__ is used in tag Name to identify resources created by this module.

If __availability_zones__ is not specified, module use all availability zones in the target region.

__cidr_block__ is mandatory for VPC, all subnet_groups must be given a __cidr_block__ which wil be cut
into several sub-blocks to have a subnet per availability zone on each groups. Group's __cidr_block_
must not overlap each others and must be included into VPC's __cidr_block__.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >=1.0.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >=4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.33.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_default_network_acl.self](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/default_network_acl) | resource |
| [aws_default_route_table.self](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/default_route_table) | resource |
| [aws_default_security_group.self](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/default_security_group) | resource |
| [aws_default_vpc_dhcp_options.self](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/default_vpc_dhcp_options) | resource |
| [aws_internet_gateway.self](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway) | resource |
| [aws_network_acl_rule.all_egress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_acl_rule) | resource |
| [aws_network_acl_rule.all_ingress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_acl_rule) | resource |
| [aws_route_table.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table_association.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_subnet.self](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_vpc.self](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc) | resource |
| [aws_availability_zones.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_availability_zones"></a> [availability\_zones](#input\_availability\_zones) | Target availability zones. | `list(string)` | `null` | no |
| <a name="input_cidr_block"></a> [cidr\_block](#input\_cidr\_block) | The IPv4 CIDR block for the VPC. | `string` | n/a | yes |
| <a name="input_network_acl_disabled"></a> [network\_acl\_disabled](#input\_network\_acl\_disabled) | If disabled, default Network ACLs allow all inbound and outbound protocols. | `bool` | `true` | no |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | Value used to prefix resources name. | `string` | `"noname"` | no |
| <a name="input_subnet_groups"></a> [subnet\_groups](#input\_subnet\_groups) | One subnet in each availablity zone is created per subnet group. | <pre>map(object({<br>    cidr_block = string<br>    public     = optional(bool, false)<br>  }))</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aws_availability_zones"></a> [aws\_availability\_zones](#output\_aws\_availability\_zones) | List of available AZ names. |
| <a name="output_subnet_ids"></a> [subnet\_ids](#output\_subnet\_ids) | Lisr of public subnet IDs. |
| <a name="output_vpc"></a> [vpc](#output\_vpc) | value |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
