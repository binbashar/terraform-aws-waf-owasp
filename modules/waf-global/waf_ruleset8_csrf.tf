## 8.
## OWASP Top 10 A8
## CSRF token enforcement example
## Enforce the presence of CSRF token in request header

resource aws_waf_rule enforce_csrf {
  name        = "${var.waf_prefix}-generic-enforce-csrf"
  metric_name = replace("${var.waf_prefix}genericenforcecsrf", "/[^0-9A-Za-z]/", "")

  predicates {
    data_id = aws_waf_byte_match_set.match_csrf_method.id
    negated = false
    type    = "ByteMatch"
  }

  predicates {
    data_id = aws_waf_size_constraint_set.csrf_token_set.id
    negated = true
    type    = "SizeConstraint"
  }
}

resource aws_waf_byte_match_set match_csrf_method {
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

resource aws_waf_size_constraint_set csrf_token_set {
  name = "${var.waf_prefix}-generic-match-csrf-token"

  size_constraints {
    text_transformation = "NONE"
    comparison_operator = "EQ"
    size                = "36"

    field_to_match {
      type = "HEADER"
      data = "x-csrf-token"
    }
  }
}

