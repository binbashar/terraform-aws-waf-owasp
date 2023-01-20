## 10.
## Generic
## IP Blacklist
## Matches IP addresses that should not be allowed to access content

resource "aws_wafregional_rule" "detect_blacklisted_ips" {
  name        = "${var.waf_prefix}-generic-detect-blacklisted-ips"
  metric_name = replace("${var.waf_prefix}genericdetectblacklistedips", "/[^0-9A-Za-z]/", "")

  predicate {
    data_id = aws_wafregional_ipset.blacklisted_ips.id
    negated = false
    type    = "IPMatch"
  }
}

resource "aws_wafregional_ipset" "blacklisted_ips" {
  name = "${var.waf_prefix}-generic-match-blacklisted-ips"
  dynamic "ip_set_descriptor" {
    for_each = var.blacklisted_ips

    content {
      type  = "IPV4"
      value = ip_set_descriptor.value
    }
  }
}

## 10.
## Generic
## IP Whitelist
## Matches IP addresses that should be allowed to access content

resource "aws_wafregional_rule" "detect_whitelisted_ips" {
  name        = "${var.waf_prefix}-generic-detect-whitelisted-ips"
  metric_name = replace("${var.waf_prefix}genericdetectwhitelistedips", "/[^0-9A-Za-z]/", "")

  predicate {
    data_id = aws_wafregional_ipset.whitelisted_ips.id
    negated = false
    type    = "IPMatch"
  }
}

resource "aws_wafregional_ipset" "whitelisted_ips" {
  name = "${var.waf_prefix}-generic-match-whitelisted-ips"
  dynamic "ip_set_descriptor" {
    for_each = var.whitelisted_ips

    content {
      type  = "IPV4"
      value = ip_set_descriptor.value
    }
  }
}
