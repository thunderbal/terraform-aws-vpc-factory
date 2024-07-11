# variables.tf

variable "config_file" {
  description = "Network configuration file."
  type        = string
  default     = null
}

variable "config_template" {
  description = "value"
  type        = string
  default     = "default"

  validation {
    condition     = contains(["default", "standard", "eks"], var.config_template)
    error_message = "config_template must be one of 'default' 'eks'"
  }
}
