variable DeploymentRegion {
  default = "eu-central-1"
  type = string
}

variable DeploymentName {
  default = "S3PL"
  type = string
}

variable "VPC_CIDR" {
  type = string
  default = "10.252.0.0/24"
}
