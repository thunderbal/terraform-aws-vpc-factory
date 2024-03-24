# variables.tf

variable "prefix" {
  description = "Value used to prefix resources name."
  type        = string
  default     = "noname"
}

variable "cidr_block" {
  description = "The IPv4 CIDR block for the VPC."
  type        = string
}

variable "availability_zones" {
  description = "Target availability zones."
  type        = list(string)
  default     = null
}

variable "network_acl_disabled" {
  description = "If disabled, default Network ACLs allow all inbound and outbound protocols."
  type        = bool
  default     = true
}

variable "subnet_groups" {
  description = "One subnet in each availablity zone is created per subnet group."
  type = map(object({
    cidr_block = string
    public     = optional(bool, false)
  }))
}
