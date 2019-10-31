## 5.
## OWASP Top 10 A4
## Privileged Module Access Restrictions
## Restrict access to the admin interface to known source IPs only
## Matches the URI prefix, when the remote IP isn't in the whitelist

resource "aws_wafregional_rule" "detect_admin_access" {
  name        = "${var.waf_prefix}-generic-detect-admin-access"
  metric_name = replace("${var.waf_prefix}genericdetectadminaccess", "/[^0-9A-Za-z]/", "")

  predicate {
    data_id = aws_wafregional_ipset.admin_remote_ipset.id
    negated = true
    type    = "IPMatch"
  }

  predicate {
    data_id = aws_wafregional_byte_match_set.match_admin_url.id
    negated = false
    type    = "ByteMatch"
  }
}

resource "aws_wafregional_ipset" "admin_remote_ipset" {
  name = "${var.waf_prefix}-generic-match-admin-remote-ip"
  dynamic "ip_set_descriptor" {
    for_each = var.admin_remote_ipset
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

resource "aws_wafregional_byte_match_set" "match_admin_url" {
  name = "${var.waf_prefix}-generic-match-admin-url"

  byte_match_tuples {
    text_transformation   = "URL_DECODE"
    target_string         = "/admin"
    positional_constraint = "STARTS_WITH"

    field_to_match {
      type = "URI"
    }
  }
}

