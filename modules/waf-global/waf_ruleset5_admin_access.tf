## 5.
## OWASP Top 10 A4
## Privileged Module Access Restrictions
## Restrict access to the admin interface to known source IPs only
## Matches the URI prefix, when the remote IP isn't in the whitelist

resource aws_waf_rule detect_admin_access {
  name        = "${var.waf_prefix}-generic-detect-admin-access"
  metric_name = replace("${var.waf_prefix}genericdetectadminaccess", "/[^0-9A-Za-z]/", "")

  predicates {
    data_id = aws_waf_ipset.admin_remote_ipset.id
    negated = true
    type    = "IPMatch"
  }

  predicates {
    data_id = aws_waf_byte_match_set.match_admin_url.id
    negated = false
    type    = "ByteMatch"
  }
}

resource aws_waf_ipset admin_remote_ipset {
  name = "${var.waf_prefix}-generic-match-admin-remote-ip"
  dynamic ip_set_descriptors {
    for_each = var.admin_remote_ipset

    content {
      type  = "IPV4"
      value = ip_set_descriptors.value
    }
  }
}

resource aws_waf_byte_match_set match_admin_url {
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

