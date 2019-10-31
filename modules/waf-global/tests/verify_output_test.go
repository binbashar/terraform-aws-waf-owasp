package tests

import (
    "testing"

    "github.com/gruntwork-io/terratest/modules/terraform"
    "github.com/stretchr/testify/assert"
)

func TestAwsWaf(t *testing.T) {
    expectedValue1  := "bb-dev-test-generic-owasp-acl"
    expectedValue2  := "bbdevtestgenericowaspacl"

    terraformOptions := &terraform.Options {
        // The path to where our Terraform code is located
        TerraformDir: "fixture/",

        // Disable colors in Terraform commands so its easier to parse stdout/stderr
        NoColor: true,
    }

    // At the end of the test, run `terraform destroy` to clean up any resources that were created
    defer terraform.Destroy(t, terraformOptions)

    // This will run `terraform init` and `terraform apply` and fail the test if there are any errors
    terraform.InitAndApply(t, terraformOptions)

    // Run `terraform output` to get the values of output variables
    actualOutput1   := terraform.Output(t, terraformOptions, "web_acl_name")
    actualOutput2   := terraform.Output(t, terraformOptions, "web_acl_metric_name")

    // Verify we're getting back the outputs we expect
    assert.Equal(t, expectedValue1, actualOutput1)
    assert.Equal(t, expectedValue2, actualOutput2)
}
