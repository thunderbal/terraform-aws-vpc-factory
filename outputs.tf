output "aws_availability_zones" {
  description = "List of available AZ names."
  value       = data.aws_availability_zones.current.names
}

output "vpc" {
  description = "value"
  value       = aws_vpc.self
}
