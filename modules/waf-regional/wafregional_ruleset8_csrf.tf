## 8.
## OWASP Top 10 A8
## CSRF token enforcement example
## Enforce the presence of CSRF token in request header

resource "aws_wafregional_rule" "enforce_csrf" {
  name        = "${var.waf_prefix}-generic-enforce-csrf"
  metric_name = replace("${var.waf_prefix}genericenforcecsrf", "/[^0-9A-Za-z]/", "")

  predicate {
    data_id = aws_wafregional_byte_match_set.match_csrf_method.id
    negated = false
    type    = "ByteMatch"
  }

  predicate {
    data_id = aws_wafregional_size_constraint_set.csrf_token_set.id
    negated = true
    type    = "SizeConstraint"
  }

  predicate {
    data_id = aws_wafregional_byte_match_set.csrf_fetch_same_site.id
    negated = true
    type    = "ByteMatch"
  }

  predicate {
    data_id = aws_wafregional_byte_match_set.csrf_fetch_same_origin.id
    negated = true
    type    = "ByteMatch"
  }
}

resource "aws_wafregional_byte_match_set" "match_csrf_method" {
  name = "${var.waf_prefix}-generic-match-csrf-method"

  byte_match_tuples {
    text_transformation   = "LOWERCASE"
    target_string         = "post"
    positional_constraint = "EXACTLY"

    field_to_match {
      type = "METHOD"
    }
  }
}

resource "aws_wafregional_size_constraint_set" "csrf_token_set" {
  name = "${var.waf_prefix}-generic-match-csrf-token"

  size_constraints {
    text_transformation = "NONE"
    comparison_operator = "EQ"
    size                = "36"

    field_to_match {
      type = "HEADER"
      data = var.rule_csrf_header
    }
  }
}

resource "aws_wafregional_byte_match_set" "csrf_fetch_same_site" {
  name = "${var.waf_prefix}-generic-match-fetch-same-site"

  size_constraints {
    text_transformation   = "LOWERCASE"
    target_string         = "same-site"
    positional_constraint = "EXACTLY"

    field_to_match {
      type = "HEADER"
      data = "sec-fetch-site"
    }
  }
}

resource "aws_wafregional_byte_match_set" "csrf_fetch_same_origin" {
  name = "${var.waf_prefix}-generic-match-fetch-same-origin"

  size_constraints {
    text_transformation   = "LOWERCASE"
    target_string         = "same-origin"
    positional_constraint = "EXACTLY"

    field_to_match {
      type = "HEADER"
      data = "sec-fetch-site"
    }
  }
}
