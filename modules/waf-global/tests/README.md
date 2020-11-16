# Terraform Module Tests: Terratests

## Overview
Terratest is a Go library that makes it easier to write automated tests for your infrastructure code.
It provides a variety of helper functions and patterns for common infrastructure testing tasks, including:
- Testing Terraform code
- Working with AWS APIs
- And much more

Official **terratest** [documentation available on GitHub project repo](https://github.com/gruntwork-io/terratest).
Ref Article [available on Medium maintainers blog](https://blog.gruntwork.io/open-sourcing-terratest-a-swiss-army-knife-for-testing-infrastructure-code-5d883336fcd5).

### Install requirements

Terratest uses the Go testing framework. To use terratest, you need to install:

- [Go](https://golang.org/) (requires version >=1.10)
- [dep](https://github.com/golang/dep) (requires version >=0.5.1)

## Files Organization
* Terraform files are located at the root of this directory.
* Tests can be found under tests/ directory.

## Testing
### Key Points
* We use `terratest` for testing this module.
* Keep in mind that `terratest` is not a binary but a Go library with helpers that make it easier to work with Terraform and other tools.
* Test files use `_test` suffix. E.g.: `create_file_with_default_values_test.go`
* Test classes use `Test` prefix. E.g.: `func TestCreateFileWithDefaultValues(t *testing.T) {`
* Our tests make use of a fixture/ dir that resembles how the module will be used.

### Set Up

#### Dokerized Makefile
```
$ make
Available Commands:
...
 - terratest-dep-init dep is a dependency management tool for Go. (https://github.com/golang/dep)
 - terratest-go-test  lint: TFLint is a Terraform linter for detecting errors that can not be detected by terraform plan.
...
```

1.  `make terratest-dep-init`
```
$ make terratest-dep-init
docker run --rm -v /home/delivery/Binbash/repos/BB-Leverage/terraform/terraform-aws-ec2-jenkins-vault:"/go/src/project/":rw -v ~/.ssh:/root/.ssh -v ~/.gitconfig:/etc/gitconfig --entrypoint=dep -it binbash/terraform-resources:0.11.14 init
  Locking in master (da137c7) for transitive dep golang.org/x/net
  Using ^1.3.0 as constraint for direct dep github.com/stretchr/testify
  Locking in v1.3.0 (ffdc059) for direct dep github.com/stretchr/testify
  Locking in v1.0.0 (792786c) for transitive dep github.com/pmezard/go-difflib
  Using ^0.17.5 as constraint for direct dep github.com/gruntwork-io/terratest
  Locking in v0.17.5 (03959c9) for direct dep github.com/gruntwork-io/terratest
  Locking in v1.1.1 (8991bc2) for transitive dep github.com/davecgh/go-spew
  Locking in master (4def268) for transitive dep golang.org/x/crypto
  Locking in master (04f50cd) for transitive dep golang.org/x/sys
docker run --rm -v /home/delivery/Binbash/repos/BB-Leverage/terraform/terraform-aws-ec2-jenkins-vault:"/go/src/project/":rw -v ~/.ssh:/root/.ssh -v ~/.gitconfig:/etc/gitconfig --entrypoint=dep -it binbash/terraform-resources:0.11.14 ensure
sudo chown -R delivery:delivery .
cp -r ./vendor ./tests/ && rm -rf ./vendor
cp -r ./Gopkg* ./tests/ && rm -rf ./Gopkg*
```

2. `terratest-go-test`
```
TestInstanceJenkinsVault 2019-07-08T02:42:42Z command.go:158: Destroy complete! Resources: 23 destroyed.
TestInstanceJenkinsVault 2019-07-08T02:42:42Z command.go:158:
...
TestInstanceJenkinsVault 2019-07-08T02:42:42Z command.go:158:
TestInstanceJenkinsVault 2019-07-08T02:42:42Z command.go:158: Warning: output "aws_s3_bucket_ssl_certificates_bucket_domain_name": must use splat syntax to access aws_s3_bucket.ssl_certificates_bucket attribute "bucket_domain_name", because it has "count" set; use aws_s3_bucket.ssl_certificates_bucket.*.bucket_domain_name to obtain a list of the attributes across all instances
TestInstanceJenkinsVault 2019-07-08T02:42:42Z command.go:158:
TestInstanceJenkinsVault 2019-07-08T02:42:42Z command.go:158:
PASS
ok      project/tests   227.167s
sudo chown -R delivery:delivery .

```

#### Local installed deps execution
* Make sure this module is within the **GOPATH directory**.
    * Default GOPATH is usually set to `$HOME/go` but you can override that permanently or temporarily.
    * For instance, you could place all your modules under `/home/john.doe/project_name/tf-modules/src/`
    * Then you would use `export GOPATH=/home/john.doe/project_name/tf-modules/`
    * Or you could simply place all your modules under `$HOME/go/src/`
* Go to the `tests/` dir and run `dep ensure` to resolve all dependencies.
    * This should create a `vendor/` dir under `tests/` dir and also a `pkg/` dir under the GOPATH dir.
* Now you can run `go test`


### Tests Result: Passing
```
TestAwsWaf 2019-10-31T18:46:44Z command.go:158: module.waf_global_test.aws_waf_byte_match_set.match_ssi: Still destroying... [id=5768e332-3203-41f2-9985-01c04c2f1c84, 10s elapsed]
TestAwsWaf 2019-10-31T18:46:44Z command.go:158: module.waf_global_test.aws_waf_byte_match_set.match_auth_tokens: Still destroying... [id=64932756-fd35-4858-b347-287a0d3e6b37, 30s elapsed]
TestAwsWaf 2019-10-31T18:46:45Z command.go:158: module.waf_global_test.aws_waf_byte_match_set.match_rfi_lfi_traversal: Destruction complete after 43s
TestAwsWaf 2019-10-31T18:46:46Z command.go:158: module.waf_global_test.aws_waf_byte_match_set.match_php_insecure_var_refs: Still destroying... [id=3ade79c3-3eb1-4202-9673-63603aa62d02, 40s elapsed]
TestAwsWaf 2019-10-31T18:46:47Z command.go:158: module.waf_global_test.aws_waf_byte_match_set.match_php_insecure_uri: Destruction complete after 43s
TestAwsWaf 2019-10-31T18:46:48Z command.go:158: module.waf_global_test.aws_waf_sql_injection_match_set.sql_injection_match_set: Still destroying... [id=827e5d19-c5ae-4a33-b85a-43aa7a993cf6, 40s elapsed]
TestAwsWaf 2019-10-31T18:46:49Z command.go:158: module.waf_global_test.aws_waf_xss_match_set.xss_match_set: Still destroying... [id=12dfaa5e-b175-4625-88a1-769794255b66, 10s elapsed]
TestAwsWaf 2019-10-31T18:46:49Z command.go:158: module.waf_global_test.aws_waf_byte_match_set.match_php_insecure_var_refs: Destruction complete after 44s
TestAwsWaf 2019-10-31T18:46:50Z command.go:158: module.waf_global_test.aws_waf_byte_match_set.match_admin_url: Still destroying... [id=5b34eb2c-61b9-414a-9517-d112e27e16e9, 40s elapsed]
TestAwsWaf 2019-10-31T18:46:51Z command.go:158: module.waf_global_test.aws_waf_sql_injection_match_set.sql_injection_match_set: Destruction complete after 44s
TestAwsWaf 2019-10-31T18:46:53Z command.go:158: module.waf_global_test.aws_waf_byte_match_set.match_admin_url: Destruction complete after 44s
TestAwsWaf 2019-10-31T18:46:54Z command.go:158: module.waf_global_test.aws_waf_byte_match_set.match_ssi: Still destroying... [id=5768e332-3203-41f2-9985-01c04c2f1c84, 20s elapsed]
TestAwsWaf 2019-10-31T18:46:54Z command.go:158: module.waf_global_test.aws_waf_byte_match_set.match_auth_tokens: Still destroying... [id=64932756-fd35-4858-b347-287a0d3e6b37, 40s elapsed]
TestAwsWaf 2019-10-31T18:46:57Z command.go:158: module.waf_global_test.aws_waf_byte_match_set.match_auth_tokens: Destruction complete after 43s
TestAwsWaf 2019-10-31T18:46:59Z command.go:158: module.waf_global_test.aws_waf_xss_match_set.xss_match_set: Still destroying... [id=12dfaa5e-b175-4625-88a1-769794255b66, 20s elapsed]
TestAwsWaf 2019-10-31T18:47:02Z command.go:158: module.waf_global_test.aws_waf_byte_match_set.match_ssi: Destruction complete after 28s
TestAwsWaf 2019-10-31T18:47:04Z command.go:158: module.waf_global_test.aws_waf_xss_match_set.xss_match_set: Destruction complete after 26s
TestAwsWaf 2019-10-31T18:47:04Z command.go:158:
TestAwsWaf 2019-10-31T18:47:04Z command.go:158: Destroy complete! Resources: 24 destroyed.
PASS
ok      project/tests   271.951s
sudo chown -R delivery:delivery .
```


## Code Linting & Static Code Analysis

* The `terraform fmt` command is used to rewrite Terraform configuration files to a canonical format and style.
  This command applies a subset of the Terraform language style conventions, along with other minor adjustments for
  readability. (https://www.terraform.io/docs/commands/fmt.html)
* TFLint is a Terraform linter focused on possible errors, best practices, etc. (https://github.com/wata727/tflint)

```
# delivery @ delivery-I7567 in ~/Binbash/repos/BB-Leverage/terraform/terraform-aws-cost-budget on git:BBL-121-fix-budget-sns-policy x [15:32:08]
$ make
Available Commands:
 ...
 - format             The terraform fmt is used to rewrite tf conf files to a canonical format and style.
 - lint               TFLint is a Terraform linter for detecting errors that can not be detected by terraform plan.
 ...

# delivery @ delivery-I7567 in ~/Binbash/repos/BB-Leverage/terraform/terraform-aws-cost-budget on git:BBL-121-fix-budget-sns-policy o [15:31:47]
$ make format
docker run --rm -v /home/delivery/Binbash/repos/BB-Leverage/terraform/terraform-aws-cost-budget:"/go/src/project/":rw --entrypoint=/usr/local/go/bin/terraform -it binbash/terraform-resources:0.11.14 fmt "/go/src/project/"
/go/src/project/outputs.tf
/go/src/project/sns.tf
/go/src/project/tests/fixture/main.tf
/go/src/project/tests/fixture/outputs.tf
/go/src/project/tests/fixture/variables.tf



# delivery @ delivery-I7567 in ~/Binbash/repos/BB-Leverage/terraform/terraform-aws-cost-budget on git:BBL-121-fix-budget-sns-policy x [15:34:45]
$ make lint
docker run --rm -v /home/delivery/Binbash/repos/BB-Leverage/terraform/terraform-aws-cost-budget:/data -t wata727/tflint --deep
Awesome! Your code is following the best practices :)
```