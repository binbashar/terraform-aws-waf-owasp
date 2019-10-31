#
# WAF
#
output "web_acl_id" {
  value = module.waf_regional_test.web_acl_id
}

output "web_acl_name" {
  value = module.waf_regional_test.web_acl_name
}

output "web_acl_metric_name" {
  value = module.waf_regional_test.web_acl_metric_name
}