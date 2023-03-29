<a href="https://github.com/binbashar">
    <img src="https://raw.githubusercontent.com/binbashar/le-ref-architecture-doc/master/docs/assets/images/logos/binbash-leverage-banner.png" width="1032" align="left" alt="Binbash"/>
</a>
<br clear="left"/>

# Terraform | AWS WAF | OWASP Top 10 vulnerabilities

**DEPRECATION NOTICE:** This module will be not longer maintain because there are other Terraform modules that support these features based on ´wafv2´ Managed rules for AWS Web Application Firewall

## terraform-aws-waf-owasp

### IMPORTANT CONSIDERATIONS
1. The original source was taken from https://github.com/Twinuma/terraform-waf-owasp and was adapted to the needs of the project at hand.
We've also had https://registry.terraform.io/modules/juiceinc/juiceinc-waf as reference.

2. **SUB-MODULE SELECTION**
    * **Global WAF** for CloudFront usage
    * **Regional WAF** for Regional/ALB and/or API Gateway Stage usage

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

<div align="left">
  <img src="https://raw.githubusercontent.com/binbashar/terraform-aws-waf-owasp/master/figures/binbash-tf-aws-waf.png" alt="leverage" width="430"/>
</div>

**For more information:**
* AWS Blog - https://aws.amazon.com/about-aws/whats-new/2017/07/use-aws-waf-to-mitigate-owasps-top-10-web-application-vulnerabilities/

### This module will create:
 1. match-sets[[5]](https://docs.aws.amazon.com/waf/latest/developerguide/web-acl-create-condition.html), to be associated with rules.
 2. rules[[6]](https://docs.aws.amazon.com/waf/latest/developerguide/web-acl-rules.html),
 3. WebACL[[7]](https://docs.aws.amazon.com/waf/latest/developerguide/web-acl-working-with.html), resources 1 and 2 cannot be used without 3.

<div align="left">
  <img src="https://raw.githubusercontent.com/binbashar/terraform-aws-waf-owasp/master/figures/binbash-aws-tf-waf-diagram.png" alt="leverage" width="630"/>
</div>

**NOTE:** Diagram to be taken just as reference, needs update to reflect the exact deployed resources.

References
* [1] : https://www.owasp.org/index.php/Category:OWASP_Top_Ten_Project
* [2] : https://www.owasp.org/images/7/72/OWASP_Top_10-2017_%28en%29.pdf.pdf
* [3] : https://d0.awsstatic.com/whitepapers/Security/aws-waf-owasp.pdf
* [4] : https://aws.amazon.com/about-aws/whats-new/2017/07/use-aws-waf-to-mitigate-owasps-top-10-web-application-vulnerabilities/
* [5] : https://docs.aws.amazon.com/waf/latest/developerguide/web-acl-create-condition.html
* [6] : https://docs.aws.amazon.com/waf/latest/developerguide/web-acl-rules.html
* [7] : https://docs.aws.amazon.com/waf/latest/developerguide/web-acl-working-with.html

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12.28 |
| aws | >= 2.70.0 |

## Providers

| Name | Version |
|------|---------|
| aws | >= 2.70.0 |

## Parameters are almost synced in both waf-regional and waf-global modules
- [waf-global-parameters](./modules/waf-global/README.md)
- [waf-regional-parameters](./modules/waf-regional/README.md)

## Examples
### waf-regional
#### waf-regional-alb
```terraform
module "waf_regional_test" {
    source = "github.com:binbashar/terraform-aws-owasp.git//modules/waf-regional?ref=v1.0.4"

    # Just a prefix to add some level of organization
    waf_prefix = "test"

    # List of IPs that are blacklisted
    blacklisted_ips = []

    # List of IPs that are allowed to access admin pages
    admin_remote_ipset = []

    # Pass the list of resources ARNs that the WAF ACL will be connected to. (For example, an Application Load Balancer or API Gateway Stage.)
    resource_arn = [
        "arn:aws:elasticloadbalancing:us-east-2:1234567890:loadbalancer/app/some-LB-ABCD1233/12345111",
        "arn:aws:elasticloadbalancing:us-east-2:1234567890:loadbalancer/app/some-LB-ABCD1244/12345222"
    ]

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

    # Set custom header for CSRF Token
    custom_csrf_token = [
      {
        field = "X-Twilio-Signature"
        size = 28
        operator = "GT"
      }
    ]
}
```

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

## Binbash Leverage | DevOps Automation Code Library integration

In order to get the full automated potential of the
[Binbash Leverage DevOps Automation Code Library](https://leverage.binbash.com.ar/how-it-works/code-library/code-library/)  
you should initialize all the necessary helper **Makefiles**.

#### How?
You must execute the `make init-makefiles` command  at the corresponding context, which could be:

- Root context
    - `/`
- Module specific contexts
    - `/modules/waf-global/`
    - `/modules/waf-regional`

```shell
╭─delivery at delivery-I7567 in ~/terraform/terraform-aws-waf-owasp on master✔ 20-09-17
╰─⠠⠵ make
Available Commands:
 - init-makefiles     initialize makefiles

```

### Why?
You'll get all the necessary commands to automatically operate this module via a dockerized approach,
example shown below

```shell
╭─delivery at delivery-I7567 in ~/terraform/terraform-aws-waf-owasp on master✔ 20-09-17
╰─⠠⠵ make
Available Commands:
 - circleci-validate-config  ## Validate A CircleCI Config (https
 - format-check        ## The terraform fmt is used to rewrite tf conf files to a canonical format and style.
 - format              ## The terraform fmt is used to rewrite tf conf files to a canonical format and style.
 - tf-dir-chmod        ## run chown in ./.terraform to gran that the docker mounted dir has the right permissions
 - version             ## Show terraform version
 - init-makefiles      ## initialize makefiles
```

```shell
╭─delivery at delivery-I7567 in ~/terraform/terraform-aws-waf-owasp on master✔ 20-09-17
╰─⠠⠵ make format-check
docker run --rm -v /home/delivery/Binbash/repos/Leverage/terraform/terraform-aws-waf-owasp:"/go/src/project/":rw -v :/config -v /common.config:/common-config/common.config -v ~/.ssh:/root/.ssh -v ~/.gitconfig:/etc/gitconfig -v ~/.aws/bb:/root/.aws/bb -e AWS_SHARED_CREDENTIALS_FILE=/root/.aws/bb/credentials -e AWS_CONFIG_FILE=/root/.aws/bb/config --entrypoint=/bin/terraform -w "/go/src/project/" -it binbash/terraform-awscli-slim:0.12.28 fmt -check
```

---

# Release Management
### CircleCi PR auto-release job

<div align="left">
  <img src="https://raw.githubusercontent.com/binbashar/terraform-aws-waf-owasp/master/figures/circleci.png"
  alt="circleci" width="130"/>
</div>

- [**pipeline-job**](https://circleci.com/gh/binbashar/terraform-aws-owasp) (**NOTE:** Will only run after merged PR)
- [**releases**](https://github.com/binbashar/terraform-aws-owasp/releases)
- [**changelog**](https://github.com/binbashar/terraform-aws-owasp/blob/master/CHANGELOG.md)
