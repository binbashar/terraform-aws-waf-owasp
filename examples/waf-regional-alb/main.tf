provider "aws" {
  region = "eu-west-2"
}

#===============#
# WAF REGIONAL  #
#===============#
module "waf_regional_test" {
  source = "../../modules/waf-regional"

  # Just a prefix to add some level of organization
  waf_prefix = "test"

  # List of IPs that are blacklisted
  blacklisted_ips = []

  # List of IPs that are allowed to access admin pages
  admin_remote_ipset = []

  # Pass the list of ALB ARNs that the WAF ACL will be connected to
  alb_arn = [
    "arn:aws:elasticloadbalancing:us-east-2:1234567890:loadbalancer/app/some-LB-ABCD1233/12345678",
  ]

  # Use COUNT for test, then you can use BLOCK (by default)
  rule_action_type = "COUNT"
}
