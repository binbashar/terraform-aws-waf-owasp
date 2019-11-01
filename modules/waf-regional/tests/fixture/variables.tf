#=============================#
# AWS Provider Settings       #
#=============================#
provider "aws" {
  region  = "${var.region}"
  profile = "${var.profile}"
}

variable "region" {
  description = "AWS Region"
  default     = "us-east-1"
}

variable "profile" {
  description = "AWS Profile"
  default     = "bb-dev-deploymaster"
}

#=============================#
# Backend Config (partial)    #
#=============================#
terraform {
  required_version = ">= 0.12.12"
}

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
  default      = []
  type        = list(string)
  description = "List of IPs to blacklist"
}

variable "admin_remote_ipset" {
  default     = []
  type        = list(string)
  description = "List of IPs allowed to access admin pages"
}

// TODO: to be validated
//variable "alb_arn" {
//  default     = []
//  type        = list(string)
//  description = "List of CloudFront Distributions ARNs"
//}
