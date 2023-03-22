<div align="center">
    <img src="https://raw.githubusercontent.com/binbashar/terraform-aws-waf-owasp/master/figures/binbash.png"
    alt="drawing" width="250"/>
</div>
<div align="right">
  <img src="https://raw.githubusercontent.com/binbashar/terraform-aws-waf-owasp/master/figures/binbash-leverage-terraform.png" alt="leverage"
  width="130"/>
</div>

# Terraform | AWS WAF | OWASP Top 10 vulnerabilities

## terraform-aws-waf-owasp

**DEPRECATION NOTICE:** This module will be not longer maintain because there are other Terraform modules that support these features based on ´wafv2´ Managed rules for AWS Web Application Firewall

### IMPORTANT CONSIDERATIONS
1. The original source was taken from https://github.com/Twinuma/terraform-waf-owasp and was adapted to the needs of the project at hand.
We've also had https://registry.terraform.io/modules/juiceinc/juiceinc-waf as reference.

2. **MODULE USE CASE**
    * **Global WAF** for CloudFront usage

## Releases
- **Versions:** `<= 0.x.y` (Terraform 0.11.x compatible)
    - eg: https://registry.terraform.io/modules/binbashar/waf-owasp/aws/0.0.1

- **Versions:** `>= 1.x.y` (Terraform 0.12.x compatible)
    - eg: https://registry.terraform.io/modules/binbashar/waf-owasp/aws/1.0.0


## Use AWS WAF at terraform to Mitigate OWASP’s Top 10 Web Application Vulnerabilities

OWASP Top 10 Most Critical Web Application Security Risks is a powerful awareness document for web
application security. It represents a broad consensus about the most critical security risks to web applications.
Project members include a variety of security experts from around the world who have shared their expertise to
produce this list[[1]](https://www.owasp.org/index.php/Category:OWASP_Top_Ten_Project).
You can read the document that they published here: [[2]](https://www.owasp.org/images/7/72/OWASP_Top_10-2017_%28en%29.pdf.pdf).

This is a Terraform module which creates AWF WAF resources for protection of your resources from the OWASP Top 10
Security Risks. This module is based on the whitepaper that AWS provides. The whitepaper tells how to use AWS WAF
to mitigate those attacks[[3]](https://d0.awsstatic.com/whitepapers/Security/aws-waf-owasp.pdf)[[4]](https://aws.amazon.com/about-aws/whats-new/2017/07/use-aws-waf-to-mitigate-owasps-top-10-web-application-vulnerabilities/).

### This module will create:
 1. match-sets[[5]](https://docs.aws.amazon.com/waf/latest/developerguide/web-acl-create-condition.html), to be associated with rules.
 2. rules[[6]](https://docs.aws.amazon.com/waf/latest/developerguide/web-acl-rules.html),
 3. WebACL[[7]](https://docs.aws.amazon.com/waf/latest/developerguide/web-acl-working-with.html), resources 1 and 2 cannot be used without 3.

References
* [1] : https://www.owasp.org/index.php/Category:OWASP_Top_Ten_Project
* [2] : https://www.owasp.org/images/7/72/OWASP_Top_10-2017_%28en%29.pdf.pdf
* [3] : https://d0.awsstatic.com/whitepapers/Security/aws-waf-owasp.pdf
* [4] : https://aws.amazon.com/about-aws/whats-new/2017/07/use-aws-waf-to-mitigate-owasps-top-10-web-application-vulnerabilities/
* [5] : https://docs.aws.amazon.com/waf/latest/developerguide/web-acl-create-condition.html
* [6] : https://docs.aws.amazon.com/waf/latest/developerguide/web-acl-rules.html
* [7] : https://docs.aws.amazon.com/waf/latest/developerguide/web-acl-working-with.html

**For more information:**
* AWS Blog - https://aws.amazon.com/about-aws/whats-new/2017/07/use-aws-waf-to-mitigate-owasps-top-10-web-application-vulnerabilities/

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.12.28 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 2.70.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 2.70.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_waf_byte_match_set.match_admin_url](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/waf_byte_match_set) | resource |
| [aws_waf_byte_match_set.match_auth_tokens](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/waf_byte_match_set) | resource |
| [aws_waf_byte_match_set.match_csrf_method](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/waf_byte_match_set) | resource |
| [aws_waf_byte_match_set.match_php_insecure_uri](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/waf_byte_match_set) | resource |
| [aws_waf_byte_match_set.match_php_insecure_var_refs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/waf_byte_match_set) | resource |
| [aws_waf_byte_match_set.match_rfi_lfi_traversal](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/waf_byte_match_set) | resource |
| [aws_waf_byte_match_set.match_ssi](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/waf_byte_match_set) | resource |
| [aws_waf_ipset.admin_remote_ipset](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/waf_ipset) | resource |
| [aws_waf_ipset.blacklisted_ips](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/waf_ipset) | resource |
| [aws_waf_rule.detect_admin_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/waf_rule) | resource |
| [aws_waf_rule.detect_bad_auth_tokens](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/waf_rule) | resource |
| [aws_waf_rule.detect_blacklisted_ips](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/waf_rule) | resource |
| [aws_waf_rule.detect_php_insecure](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/waf_rule) | resource |
| [aws_waf_rule.detect_rfi_lfi_traversal](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/waf_rule) | resource |
| [aws_waf_rule.detect_ssi](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/waf_rule) | resource |
| [aws_waf_rule.enforce_csrf](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/waf_rule) | resource |
| [aws_waf_rule.mitigate_sqli](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/waf_rule) | resource |
| [aws_waf_rule.mitigate_xss](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/waf_rule) | resource |
| [aws_waf_rule.restrict_sizes](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/waf_rule) | resource |
| [aws_waf_size_constraint_set.csrf_token_set](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/waf_size_constraint_set) | resource |
| [aws_waf_size_constraint_set.custom_csrf_token_set](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/waf_size_constraint_set) | resource |
| [aws_waf_size_constraint_set.size_restrictions](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/waf_size_constraint_set) | resource |
| [aws_waf_sql_injection_match_set.sql_injection_match_set](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/waf_sql_injection_match_set) | resource |
| [aws_waf_web_acl.waf_acl](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/waf_web_acl) | resource |
| [aws_waf_xss_match_set.xss_match_set](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/waf_xss_match_set) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_admin_remote_ipset"></a> [admin\_remote\_ipset](#input\_admin\_remote\_ipset) | List of IPs allowed to access admin pages, ['1.1.1.1/32', '2.2.2.2/32', '3.3.3.3/32'] | `list(string)` | `[]` | no |
| <a name="input_blacklisted_ips"></a> [blacklisted\_ips](#input\_blacklisted\_ips) | List of IPs to blacklist, eg ['1.1.1.1/32', '2.2.2.2/32', '3.3.3.3/32'] | `list(string)` | `[]` | no |
| <a name="input_custom_csrf_token"></a> [custom\_csrf\_token](#input\_custom\_csrf\_token) | Custom CSRF token set | `list` | `[]` | no |
| <a name="input_rule_admin_access_action_type"></a> [rule\_admin\_access\_action\_type](#input\_rule\_admin\_access\_action\_type) | Rule action type. Either BLOCK, ALLOW, or COUNT (useful for testing) | `string` | `"COUNT"` | no |
| <a name="input_rule_auth_tokens_action"></a> [rule\_auth\_tokens\_action](#input\_rule\_auth\_tokens\_action) | Rule action type. Either BLOCK, ALLOW, or COUNT (useful for testing) | `string` | `"COUNT"` | no |
| <a name="input_rule_blacklisted_ips_action_type"></a> [rule\_blacklisted\_ips\_action\_type](#input\_rule\_blacklisted\_ips\_action\_type) | Rule action type. Either BLOCK, ALLOW, or COUNT (useful for testing) | `string` | `"COUNT"` | no |
| <a name="input_rule_csrf_action_type"></a> [rule\_csrf\_action\_type](#input\_rule\_csrf\_action\_type) | Rule action type. Either BLOCK, ALLOW, or COUNT (useful for testing) | `string` | `"COUNT"` | no |
| <a name="input_rule_csrf_header"></a> [rule\_csrf\_header](#input\_rule\_csrf\_header) | The name of your CSRF token header. | `string` | `"x-csrf-token"` | no |
| <a name="input_rule_lfi_rfi_action"></a> [rule\_lfi\_rfi\_action](#input\_rule\_lfi\_rfi\_action) | Rule action type. Either BLOCK, ALLOW, or COUNT (useful for testing) | `string` | `"COUNT"` | no |
| <a name="input_rule_php_insecurities_action_type"></a> [rule\_php\_insecurities\_action\_type](#input\_rule\_php\_insecurities\_action\_type) | Rule action type. Either BLOCK, ALLOW, or COUNT (useful for testing) | `string` | `"COUNT"` | no |
| <a name="input_rule_size_restriction_action_type"></a> [rule\_size\_restriction\_action\_type](#input\_rule\_size\_restriction\_action\_type) | Rule action type. Either BLOCK, ALLOW, or COUNT (useful for testing) | `string` | `"COUNT"` | no |
| <a name="input_rule_sqli_action"></a> [rule\_sqli\_action](#input\_rule\_sqli\_action) | Rule action type. Either BLOCK, ALLOW, or COUNT (useful for testing) | `string` | `"COUNT"` | no |
| <a name="input_rule_ssi_action_type"></a> [rule\_ssi\_action\_type](#input\_rule\_ssi\_action\_type) | Rule action type. Either BLOCK, ALLOW, or COUNT (useful for testing) | `string` | `"COUNT"` | no |
| <a name="input_rule_whitelisted_ips_action_type"></a> [rule\_whitelisted\_ips\_action\_type](#input\_rule\_whitelisted\_ips\_action\_type) | Rule action type. Either BLOCK, ALLOW, or COUNT (useful for testing) | `string` | `"ALLOW"` | no |
| <a name="input_rule_xss_action"></a> [rule\_xss\_action](#input\_rule\_xss\_action) | Rule action type. Either BLOCK, ALLOW, or COUNT (useful for testing) | `string` | `"COUNT"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A mapping of tags to assign to all resources | `map(string)` | `{}` | no |
| <a name="input_waf_prefix"></a> [waf\_prefix](#input\_waf\_prefix) | Prefix to use when naming resources | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_web_acl_id"></a> [web\_acl\_id](#output\_web\_acl\_id) | AWS WAF web acl id. |
| <a name="output_web_acl_metric_name"></a> [web\_acl\_metric\_name](#output\_web\_acl\_metric\_name) | The name or description for the Amazon CloudWatch metric of this web ACL. |
| <a name="output_web_acl_name"></a> [web\_acl\_name](#output\_web\_acl\_name) | The name or description of the web ACL. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Examples
### waf-global
#### waf-global-cloudfront
```terraform
module "waf_regional_test" {
    source = "github.com:binbashar/terraform-aws-owasp.git//modules/waf-global?ref=v1.0.4"

    # Just a prefix to add some level of organization
    waf_prefix = "test"

    # List of IPs that are blacklisted
    blacklisted_ips = []

    # List of IPs that are allowed to access admin pages
    admin_remote_ipset = []

    # By default seted to COUNT for testing in order to avoid service affection; when ready, set it to BLOCK
    rule_size_restriction_action_type   = "COUNT"
    rule_sqli_action                    = "COUNT"
    rule_xss_action                     = "COUNT"
    rule_lfi_rfi_action                 = "COUNT"
    rule_ssi_action_type                = "COUNT"
    rule_auth_tokens_action             = "COUNT"
    rule_admin_access_action_type       = "COUNT"
    rule_php_insecurities_action_type   = "COUNT"
    rule_csrf_action_type               = "COUNT"
    rule_blacklisted_ips_action_type    = "COUNT"
}
```
