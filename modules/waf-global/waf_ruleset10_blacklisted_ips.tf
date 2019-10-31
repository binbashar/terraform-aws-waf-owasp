## 10.
## Generic
## IP Blacklist
## Matches IP addresses that should not be allowed to access content

resource "aws_waf_rule" "detect_blacklisted_ips" {
  name        = "${var.waf_prefix}-generic-detect-blacklisted-ips"
  metric_name = replace("${var.waf_prefix}genericdetectblacklistedips", "/[^0-9A-Za-z]/", "")

  predicates {
    data_id = aws_waf_ipset.blacklisted_ips.id
    negated = false
    type    = "IPMatch"
  }
}

resource "aws_waf_ipset" "blacklisted_ips" {
  name = "${var.waf_prefix}-generic-match-blacklisted-ips"
  dynamic "ip_set_descriptors" {
    for_each = var.blacklisted_ips
    content {
      //resource "aws_waf_ipset" "test" {
      //  name = "test"
      //
      //  dynamic "ip_set_descriptors" {
      //    # The for_each argument is a hardcoded list in this illustrative example,
      //    # however it can be sourced from a variable or local value as well as
      //    # support multiple argument values as a map.
      //    for_each = ["1.1.1.1/32", "2.2.2.2/32", "3.3.3.3/32"]
      //
      //    content {
      //      type  = "IPV4"
      //      value = ip_set_descriptors.value
      //    }
      //  }
      //}
      //
      //output "test" {
      //  value = aws_waf_ipset.test.ip_set_descriptors[*].value
      //}

      type  = "IPV4"
      value = ip_set_descriptors.value
    }
  }
}