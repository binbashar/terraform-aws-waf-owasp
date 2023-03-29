#
# Define some input just to show how variables can be passed from the test.
#
#variable "countries" {
#    description = "Countries"
#    default     = "AR,BR,CH"
#}

#
# Instantiate the module.
#
#module "backend" {
#    source      = "../../"
#
#    countries   = "${var.countries}"
#}

#
# Output the module's output for verification.
#
#output "countries" {
#    value = "${module.sample.countries}"
#}

#=================#
# WAF REGIONAL    #
#=================#
module "waf_regional_test" {
  source = "../../"

  # Just a prefix to add some level of organization
  waf_prefix = "${var.project}-${var.environment}"

  # List of IPs that are blacklisted
  blacklisted_ips = var.blacklisted_ips

  # List of IPs that are allowed to access admin pages
  admin_remote_ipset = var.admin_remote_ipset

  # Pass the list of resources ARNs that the WAF ACL will be connected to. (For example, an Application Load Balancer or API Gateway Stage.)
  resource_arn = [aws_lb.waf_assoc_1.arn, aws_lb.waf_assoc_2.arn, ]

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

  tags = local.tags
}

#==================#
# ALBs to be assoc #
#==================#
resource "aws_lb" "waf_assoc_1" {
  internal           = true
  load_balancer_type = "application"
  subnets            = [data.terraform_remote_state.vpc.outputs.private_subnets[0], data.terraform_remote_state.vpc.outputs.private_subnets[1]]
}

resource "aws_lb" "waf_assoc_2" {
  internal           = true
  load_balancer_type = "application"
  subnets            = [data.terraform_remote_state.vpc.outputs.private_subnets[0], data.terraform_remote_state.vpc.outputs.private_subnets[1]]
}
