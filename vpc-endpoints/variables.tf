data "aws_region" "current" {}

data "template_file" "endpoint-policy" {
  template = file("${path.module}/../policies/vpc-endpoint-policy.json")
}

variable DeploymentName {}

variable VPC_ID {}

variable VPC_CIDR {}

variable SubnetsID {}
