locals {
  tags = {
    Name        = "infra-waf-global-test"
    Terraform   = "true"
    Environment = "${var.environment}"
  }
}
