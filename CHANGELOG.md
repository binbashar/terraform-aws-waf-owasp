# Change Log

All notable changes to this project will be documented in this file.

<a name="unreleased"></a>
## [Unreleased]



<a name="v1.0.20"></a>
## [v1.0.20] - 2023-03-29

- Issue | Present association possibility for other resources ([#36](https://github.com/binbashar/terraform-waf-owasp/issues/36))


<a name="v1.0.19"></a>
## [v1.0.19] - 2023-03-22

- Issue | Customize CSRF headers ([#35](https://github.com/binbashar/terraform-waf-owasp/issues/35))


<a name="v1.0.18"></a>
## [v1.0.18] - 2023-02-15

- Add deprecation notice in READMEs
- Remove deprecated provider version definition
- Update README and Terraform linting
- Remove whitelist implementation
- Update README files
- Remove whitelist code
- Update waf priority rules
- Update Makefile for terraform v1.x
- Update test tf linting command
- Update script for installing terraform-docs v0.16.0
- Update terraform-doc binary and Ubuntu image
- Update variables and README files
- Update Makefile to use TF 1.x
- Update pre-commit repos
- Fix run command in CircleCI
- Update CircleCI image
- Update deprecation notice on README
- Update priorities to evaluate IPs listing first
- Update Makefile for Terratest
- Run formatting on Terraform resources
- Add waf-regional module Whitelist IPs feature
- Add waf-global module Whitelist IPs feature
- Add deprecation note in README
- Update README.md


<a name="v1.0.17"></a>
## [v1.0.17] - 2021-10-08

- Update FUNDING.yml


<a name="v1.0.16"></a>
## [v1.0.16] - 2021-10-08

- Update FUNDING.yml


<a name="v1.0.15"></a>
## [v1.0.15] - 2021-10-08

- Create FUNDING.yml


<a name="v1.0.14"></a>
## [v1.0.14] - 2020-11-16

- BBL-440 | adding terraform include at root context makefile to allow make tflint-deep during ci
- BBL-440 | fixing modules makefile-lib path
- BBL-440 | fixing modules makefile path
- BBL-440 | ci pre-commit integrated + circleci slack notif + versioned makefile added


<a name="v1.0.13"></a>
## [v1.0.13] - 2020-09-24

- BBL-381 | upgrading circleci VM executor


<a name="v1.0.12"></a>
## [v1.0.12] - 2020-09-17

- BBL-381 | readme.md improvement


<a name="v1.0.11"></a>
## [v1.0.11] - 2020-09-17

- BBL-381 | adding make related doc to README.md
- BBL-381 | changing order for AWS cred ci mgmt
- BBL-381 | fixing aws cred circleci config error
- BBL-381 | fixing circleci makefile integration
- BBL-381 | adding terratest.md to root context Makefile in order to grant CI compatibility
- BBL-381 | std repo structure + README.md update + makefile standalone approach in place + canonical format
- BBL-81 | standalone makefile repo implementation in place


<a name="v1.0.10"></a>
## [v1.0.10] - 2020-09-15

- silly copy-paste bug
- omit CSRF with sec-fetch-site same-origin / same-site


<a name="v1.0.9"></a>
## [v1.0.9] - 2020-09-09

- TIL: for_each does not create numerical indexes
- frustrating Terraform pedanticness
- check more HTTP methods for CSRF


<a name="v1.0.8"></a>
## [v1.0.8] - 2020-09-07

- allow customizing the logging configuration
- allow customizing the logging configuration
- allow customizing the logging configuration
- allow customizing the admin paths


<a name="v1.0.7"></a>
## [v1.0.7] - 2020-08-07

- BBL-218 | updating size images + make format


<a name="v1.0.6"></a>
## [v1.0.6] - 2020-08-07

- BBL-218 | fixing readme.md figure url


<a name="v1.0.5"></a>
## [v1.0.5] - 2020-08-04

- BBL-218 | fixing readme.md figure url


<a name="v1.0.4"></a>
## [v1.0.4] - 2020-08-04

- BBL-218 | replacing bb for it assoc var
- BBL-218 | disabling log_stream by default for waf-regional
- BBL-218 | sudo -H for pip awscli installation
- BBL-218 | updating .gitignore for terratests + log_destination to null to validate if it pass the tests
- BBL-218 | fixing circileci config to run tests against apps-devstg account
- BBL-218 | updating waf-regional config vpc data source + adding tags to waf-global to be tested
- BBL-218 | adding sudo to chown cmd
- BBL-218 | fixing static test aws creds permissions
- BBL-218 | fixing static test aws creds permissions
- BBL-218 | adding .editorconfig + data source for waf-regional
- BBL-218 | fixing static code analysis and linting test
- BBL-218 | fixing CI tests
- BBL-218 | make format applied to waf-global + updating csrf_token_set data to receive a custom HEADER as a variable
- BBL-218 | make format applied to waf-regional + updating csrf_token_set data to receive a custom HEADER as a variable
- BBL-218 | READMES.md have been updated with latest verions + inputs and outputs + fixed source module links
- BBL-218 | repo updated to follow the latest std structure


<a name="v1.0.3"></a>
## [v1.0.3] - 2020-01-21

- :art: Format code. Terraform 0.12.18 support
- fix typo


<a name="v1.0.2"></a>
## [v1.0.2] - 2019-12-10

- BBL-140 fixing typo in ip_set_descriptor resource
- BBL-140 waf regional alb assoc list now supported
- BBL-140 removing old terraform doc 0.12 bash scripts
- BBL-140 updating READMEs with new alb_arn var for waf regional
- BBL-140 makefiles updates tf-doc + latest tf ver


<a name="v1.0.1"></a>
## [v1.0.1] - 2019-11-01

- BBL-140 small readme update
- BBL-140 readme.md update to clear out the sub-module selection
- BBL-14 commenting ALB assoc till a complete validation takes place
- BBL-14 removing waf cloudfront assoc since this is not supported
- BBL-140 updating examples after waf assoc fix
- BBL-140 updating README.md after assoc fix


<a name="v1.0.0"></a>
## [v1.0.0] - 2019-10-31

- updating CHANGELOG.md for v1.0.0 tf-0.12
- BBL-140 small circleci job code sintaxt style change
- BBL-140 WAF Regional module e2e terratests added and validated.
- BBL-140 WAF Regional module upgrade to tf-012 support + somo minor enhancements.
- BBL-140 AWS WAF regional module aux files: makefile, readme.md, and terraform-docs 0.12 support scripts
- BBL-140 WAF Global module e2e terratest added and validated.
- BBL-140 WAF Global module upgrade to tf-012 support + somo minor enhancements.
- BBL-140 WAF Global module aux files: makefile, readme.md, and bash scripts for terraform-docs tf-0.12 support
- BBL-140 .gitignore update to avoid pushing vendor terratest generated folder
- BBL-140 updating aux files - circleci, .gitignore, makefile and README.md


<a name="v0.0.10"></a>
## [v0.0.10] - 2019-07-12

- Adding CHANGELOG.md for v0.0.10
- adding releases tf 0.12 detail in readme


<a name="v0.0.9"></a>
## [v0.0.9] - 2019-07-12

- Adding CHANGELOG.md for v0.0.9
- fixing resources properties for waf-global


<a name="v0.0.8"></a>
## [v0.0.8] - 2019-07-12

- Adding CHANGELOG.md for v0.0.8
- fixing resources properties for waf-global


<a name="v0.0.7"></a>
## [v0.0.7] - 2019-07-12

- Adding CHANGELOG.md for v0.0.7
- fixing public figure url


<a name="v0.0.6"></a>
## [v0.0.6] - 2019-07-11

- updating figures url by github raw endpoint in order to let README.md images to be publicly accesible by docker-hub and tf-registry among others
- updating README.md images urls


<a name="v0.0.5"></a>
## [v0.0.5] - 2019-07-11

- Updating aws_wafregional_web_acl_association for cloudfront comment
- Updating aws_wafregional_web_acl_association for cloudfront -> to be tested yet


<a name="v0.0.4"></a>
## [v0.0.4] - 2019-07-11

- Adding CHANGELOG.md for v0.0.4
- removing count under webacl rule, updating examples and default rule action in main.tf set to COUNT in order to avoid blocking traffic and affecting services by mistake


<a name="v0.0.3"></a>
## [v0.0.3] - 2019-07-11

- Adding CHANGELOG.md for v0.0.2
- updating README.mds urls


<a name="v0.0.2"></a>
## [v0.0.2] - 2019-07-11

- Set theme jekyll-theme-slate


<a name="v0.0.1"></a>
## v0.0.1 - 2019-07-11

- updating README.mds + dir structure for Makefiles and tests
- updating README.mds + dir structure for Makefiles and tests
- updating README.md images
- Adding changelog related files and updating image size
- Initial Commit terraform-aws-waf-owasp module


[Unreleased]: https://github.com/binbashar/terraform-waf-owasp/compare/v1.0.20...HEAD
[v1.0.20]: https://github.com/binbashar/terraform-waf-owasp/compare/v1.0.19...v1.0.20
[v1.0.19]: https://github.com/binbashar/terraform-waf-owasp/compare/v1.0.18...v1.0.19
[v1.0.18]: https://github.com/binbashar/terraform-waf-owasp/compare/v1.0.17...v1.0.18
[v1.0.17]: https://github.com/binbashar/terraform-waf-owasp/compare/v1.0.16...v1.0.17
[v1.0.16]: https://github.com/binbashar/terraform-waf-owasp/compare/v1.0.15...v1.0.16
[v1.0.15]: https://github.com/binbashar/terraform-waf-owasp/compare/v1.0.14...v1.0.15
[v1.0.14]: https://github.com/binbashar/terraform-waf-owasp/compare/v1.0.13...v1.0.14
[v1.0.13]: https://github.com/binbashar/terraform-waf-owasp/compare/v1.0.12...v1.0.13
[v1.0.12]: https://github.com/binbashar/terraform-waf-owasp/compare/v1.0.11...v1.0.12
[v1.0.11]: https://github.com/binbashar/terraform-waf-owasp/compare/v1.0.10...v1.0.11
[v1.0.10]: https://github.com/binbashar/terraform-waf-owasp/compare/v1.0.9...v1.0.10
[v1.0.9]: https://github.com/binbashar/terraform-waf-owasp/compare/v1.0.8...v1.0.9
[v1.0.8]: https://github.com/binbashar/terraform-waf-owasp/compare/v1.0.7...v1.0.8
[v1.0.7]: https://github.com/binbashar/terraform-waf-owasp/compare/v1.0.6...v1.0.7
[v1.0.6]: https://github.com/binbashar/terraform-waf-owasp/compare/v1.0.5...v1.0.6
[v1.0.5]: https://github.com/binbashar/terraform-waf-owasp/compare/v1.0.4...v1.0.5
[v1.0.4]: https://github.com/binbashar/terraform-waf-owasp/compare/v1.0.3...v1.0.4
[v1.0.3]: https://github.com/binbashar/terraform-waf-owasp/compare/v1.0.2...v1.0.3
[v1.0.2]: https://github.com/binbashar/terraform-waf-owasp/compare/v1.0.1...v1.0.2
[v1.0.1]: https://github.com/binbashar/terraform-waf-owasp/compare/v1.0.0...v1.0.1
[v1.0.0]: https://github.com/binbashar/terraform-waf-owasp/compare/v0.0.10...v1.0.0
[v0.0.10]: https://github.com/binbashar/terraform-waf-owasp/compare/v0.0.9...v0.0.10
[v0.0.9]: https://github.com/binbashar/terraform-waf-owasp/compare/v0.0.8...v0.0.9
[v0.0.8]: https://github.com/binbashar/terraform-waf-owasp/compare/v0.0.7...v0.0.8
[v0.0.7]: https://github.com/binbashar/terraform-waf-owasp/compare/v0.0.6...v0.0.7
[v0.0.6]: https://github.com/binbashar/terraform-waf-owasp/compare/v0.0.5...v0.0.6
[v0.0.5]: https://github.com/binbashar/terraform-waf-owasp/compare/v0.0.4...v0.0.5
[v0.0.4]: https://github.com/binbashar/terraform-waf-owasp/compare/v0.0.3...v0.0.4
[v0.0.3]: https://github.com/binbashar/terraform-waf-owasp/compare/v0.0.2...v0.0.3
[v0.0.2]: https://github.com/binbashar/terraform-waf-owasp/compare/v0.0.1...v0.0.2
