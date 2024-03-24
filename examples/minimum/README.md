# Minimum VPC Factory

Configuration in this directory creates a VPC with 2 groups of subnets named __public__ and __private__.
1 subnet per availability zone in the region is created on each group. Cidr block for each subnet in the
group is calculated automaticaly based on the group __cidr_block__ and the numbre of availability zone used.

The group named __public__ is declared as public, that means a route table with a default route to internet
gateway is associated to each subnet of this group.

Other subnets are routed localy inside the VPC.

__network_acl_disabled__ is set to __true__ becsause in this exemple we don't want to manage Network ACLs.
That way, the VPC default Network ACL is configure with ingress and egress rules whitch are allowing all trafic.

## Usage

To run this example you need to execute:

```bash
terraform init
terraform plan
terraform apply
```
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
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
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
