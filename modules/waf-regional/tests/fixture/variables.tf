#==============================#
# Project Variables            #
#==============================#
variable "project" {
  description = "Project id"
  default     = "bb"
}

variable "environment" {
  description = "Environment Name"
  default     = "dev-test"
}

#==============================#
# WAF                          #
#==============================#
variable "blacklisted_ips" {
  default     = []
  type        = list(string)
  description = "List of IPs to blacklist"
}

variable "admin_remote_ipset" {
  default     = []
  type        = list(string)
  description = "List of IPs allowed to access admin pages"
}

