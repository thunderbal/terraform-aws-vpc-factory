# variables.tf

variable "network_acl_disabled" {
  description = "If disabled, default Network ACLs allow all inbound and outbound protocols."
  type        = bool
  default     = true
}
