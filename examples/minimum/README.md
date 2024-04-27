# Minimum VPC Factory

Configuration in this directory creates a VPC with 2 groups of subnets named __public__ and __private__.
1 subnet per availability zone in the region is created on each group. Cidr block for each subnet in the
group is calculated automaticaly based on the group __cidr_block__ and the numbre of availability zone used.

The group named __public__ is declared as public with its default route through Internet Gatewat.

The group named __private__ has a default route to a NAT Gateway in __public__ subnets group. That means a NAT
Gateway will be created in each __public__ subnets as target default route in route tables of __private__ subnets.

__network_acl_disabled__ is set to __true__ becsause in this exemple we don't want to manage Network ACLs.
That way, the VPC default Network ACL is configure with ingress and egress rules whitch are allowing all trafic.

## Usage

To run this example you need to execute:

```bash
terraform init
terraform plan
terraform apply
```
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >=1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >=4.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_vpc"></a> [vpc](#module\_vpc) | ../.. | n/a |

## Resources

No resources.

## Inputs

No inputs.

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_module"></a> [module](#output\_module) | VPC module outputs |
<!-- END_TF_DOCS -->
