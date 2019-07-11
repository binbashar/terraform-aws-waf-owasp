# Terraform | AWS WAF | OWASP Top 10 vulnerabilities

## Important
The original source was taken from https://github.com/Twinuma/terraform-waf-owasp and was adapted to the needs of the project at hand.
We've also had https://registry.terraform.io/modules/juiceinc/juiceinc-waf as reference.

## terraform-aws-waf-owasp
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

**NOTE:** Diagram to be taken just as reference, needs update to reflect the exact deployed resources.

References
* [1] : https://www.owasp.org/index.php/Category:OWASP_Top_Ten_Project
* [2] : https://www.owasp.org/images/7/72/OWASP_Top_10-2017_%28en%29.pdf.pdf
* [3] : https://d0.awsstatic.com/whitepapers/Security/aws-waf-owasp.pdf
* [4] : https://aws.amazon.com/about-aws/whats-new/2017/07/use-aws-waf-to-mitigate-owasps-top-10-web-application-vulnerabilities/
* [5] : https://docs.aws.amazon.com/waf/latest/developerguide/web-acl-create-condition.html
* [6] : https://docs.aws.amazon.com/waf/latest/developerguide/web-acl-rules.html
* [7] : https://docs.aws.amazon.com/waf/latest/developerguide/web-acl-working-with.html


## Use AWS WAF at terraform to Mitigate OWASP’s Top 10 Web Application Vulnerabilities
* Global WAF for CloudFront usage
* Regional WAF for Regional/ALB usage

**For more information:**
* AWS Blog - https://aws.amazon.com/about-aws/whats-new/2017/07/use-aws-waf-to-mitigate-owasps-top-10-web-application-vulnerabilities/

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| admin\_remote\_ipset | List of IPs allowed to access admin pages | list | n/a | yes |
| blacklisted\_ips | List of IPs to blacklist | list | n/a | yes |
| cloudfront\_arn | List of CloudFront Distributions ARNs | list | n/a | yes |
| rule\_admin\_access\_action\_type | Rule action type. Either BLOCK, ALLOW, or COUNT (useful for testing) | string | `"BLOCK"` | no |
| rule\_auth\_tokens\_action | Rule action type. Either BLOCK, ALLOW, or COUNT (useful for testing) | string | `"BLOCK"` | no |
| rule\_blacklisted\_ips\_action\_type | Rule action type. Either BLOCK, ALLOW, or COUNT (useful for testing) | string | `"BLOCK"` | no |
| rule\_csrf\_action\_type | Rule action type. Either BLOCK, ALLOW, or COUNT (useful for testing) | string | `"BLOCK"` | no |
| rule\_lfi\_rfi\_action | Rule action type. Either BLOCK, ALLOW, or COUNT (useful for testing) | string | `"BLOCK"` | no |
| rule\_php\_insecurities\_action\_type | Rule action type. Either BLOCK, ALLOW, or COUNT (useful for testing) | string | `"BLOCK"` | no |
| rule\_size\_restriction\_action\_type | Rule action type. Either BLOCK, ALLOW, or COUNT (useful for testing) | string | `"BLOCK"` | no |
| rule\_sqli\_action | Rule action type. Either BLOCK, ALLOW, or COUNT (useful for testing) | string | `"BLOCK"` | no |
| rule\_ssi\_action\_type | Rule action type. Either BLOCK, ALLOW, or COUNT (useful for testing) | string | `"BLOCK"` | no |
| rule\_xss\_action | Rule action type. Either BLOCK, ALLOW, or COUNT (useful for testing) | string | `"BLOCK"` | no |
| waf\_prefix | Prefix to use when naming resources | string | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| web\_acl\_id |  |

## Examples
### waf-global
#### waf-global-cloudfront
```terraform
module "waf_regional_test" {
    source = "git::git@github.com:binbashar/terraform-aws-owasp.git//modules/waf-global?ref=v0.0.1"

    # Just a prefix to add some level of organization
    waf_prefix = "test"

    # List of IPs that are blacklisted
    blacklisted_ips = []

    # List of IPs that are allowed to access admin pages
    admin_remote_ipset = []

    # Pass the list of CloudFront distribution ARNs that the WAF ACL will be connected to
    cloudfront_arn = [
        "arn:aws:cloudfront::123456789012:distribution/EDFDVBD632BHDS5"
    ]

    # Use COUNT for test, then you can use BLOCK (by default)
    rule_action_type = "COUNT"
}
```