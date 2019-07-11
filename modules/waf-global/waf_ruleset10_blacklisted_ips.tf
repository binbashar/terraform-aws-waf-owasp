## 10.
## Generic
## IP Blacklist
## Matches IP addresses that should not be allowed to access content

resource "aws_waf_rule" "detect_blacklisted_ips" {
  name        = "${var.waf_prefix}-generic-detect-blacklisted-ips"
  metric_name = "${var.waf_prefix}genericdetectblacklistedips"

  predicate {
    data_id = "${aws_waf_ipset.blacklisted_ips.id}"
    negated = false
    type    = "IPMatch"
  }
}

resource "aws_waf_ipset" "blacklisted_ips" {
  name              = "${var.waf_prefix}-generic-match-blacklisted-ips"
  ip_set_descriptor = "${var.blacklisted_ips}"
}
