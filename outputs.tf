output "aws_availability_zones" {
  description = "List of available AZ names."
  value       = data.aws_availability_zones.current.names
}

output "vpc" {
  description = "value"
  value       = aws_vpc.self
}

output "subnet_ids" {
  description = "Map of public subnet IDs."
  value       = { for g in keys(var.subnet_groups) : g => [for k, v in local.subnets_attributes : aws_subnet.self[k].id if g == v.subnet_group] }
}
