variable "cidr_block" {
  description = "The IPv4 CIDR block for the VPC."
  type        = string
  default     = "10.0.0.0/16"
}

# variable "public_cidr_block" {
#   description = "Alternate CIDR block "
#   type        = string
#   default     = ""
# }

# variable "internal_cidr_block" {
#   description = "value"
#   type        = string
#   default     = ""
# }

variable "public_subnets" {
  description = "Map of public subnets"
  type = map(object({
    cidr_block = string
  }))
  default = {}
}

# variable "private_subnets" {

# }

# variable "internal_subnets" {

# }
