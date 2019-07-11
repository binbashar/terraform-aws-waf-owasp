provider "aws" {
  region = "eu-west-2"
}

#===============#
# WAF REGIONAL  #
#===============#
module "waf_regional_test" {
  source = "../../modules/waf-global"

  # Just a prefix to add some level of organization
  waf_prefix = "test"

  # List of IPs that are blacklisted
  blacklisted_ips = []

  # List of IPs that are allowed to access admin pages
  admin_remote_ipset = []

  # Pass the list of ALB ARNs that the WAF ACL will be connected to
  alb_arn = [
    "arn:aws:cloudfront::123456789012:distribution/EDFDVBD632BHDS5",
  ]

  # Use COUNT for test, then you can use BLOCK (by default)
  rule_action_type = "COUNT"
}
