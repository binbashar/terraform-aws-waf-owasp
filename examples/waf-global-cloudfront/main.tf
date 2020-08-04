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
