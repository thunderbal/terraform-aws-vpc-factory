# Default VPC Factory

Configuration in this directory creates a VPC with its default security group, option set,
route table and network ACL.

__network_acl_disabled__ is set to __false__ by default which blocks all traffic.

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
