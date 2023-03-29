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

  # Pass the list of resources ARNs that the WAF ACL will be connected to. (For example, an Application Load Balancer or API Gateway Stage.)
  resource_arn = [
    "arn:aws:elasticloadbalancing:us-east-2:1234567890:loadbalancer/app/some-LB-ABCD1233/12345111",
    "arn:aws:elasticloadbalancing:us-east-2:1234567890:loadbalancer/app/some-LB-ABCD1244/12345222"
  ]

  # By default seted to COUNT for testing in order to avoid service affection; when ready, set it to BLOCK
  rule_size_restriction_action_type = "COUNT"
  rule_sqli_action                  = "COUNT"
  rule_xss_action                   = "COUNT"
  rule_lfi_rfi_action               = "COUNT"
  rule_ssi_action_type              = "COUNT"
  rule_auth_tokens_action           = "COUNT"
  rule_admin_access_action_type     = "COUNT"
  rule_php_insecurities_action_type = "COUNT"
  rule_csrf_action_type             = "COUNT"
  rule_blacklisted_ips_action_type  = "COUNT"
}