variable "DeploymentName" {}

variable "VPC_CIDR" {}

data "aws_availability_zones" "AZs" {
  state = "available"
}
