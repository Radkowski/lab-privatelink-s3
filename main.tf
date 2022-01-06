
module "MAIN-VPC" {
  source = "./main-vpc"
  DeploymentName = var.DeploymentName
  VPC_CIDR = var.VPC_CIDR
}


module "DEPLOY-ENDPOINTS" {
  source = "./vpc-endpoints"
  DeploymentName = var.DeploymentName
  VPC_ID = module.MAIN-VPC.MainVPC_id
  VPC_CIDR = var.VPC_CIDR
  SubnetsID = module.MAIN-VPC.ARMSubnets_id
}


output "MainVPC_id" {
  value = module.MAIN-VPC.MainVPC_id
}


output "Endpoint_DNS" {
  value = module.DEPLOY-ENDPOINTS.Endpoint_DNS[0]["dns_name"]
}
