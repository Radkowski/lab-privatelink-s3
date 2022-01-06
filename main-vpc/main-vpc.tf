resource "aws_vpc" "MainVPC" {
  cidr_block                       = var.VPC_CIDR
  instance_tenancy                 = "default"
  enable_dns_hostnames             = "true"
  assign_generated_ipv6_cidr_block = "false"
  tags = {
    Name = join("", [var.DeploymentName, "-VPC"])
  }
}


resource "aws_subnet" "ARM-Subnets" {
  count                           = 2
  vpc_id                          = aws_vpc.MainVPC.id
  cidr_block                      = cidrsubnet(cidrsubnet(aws_vpc.MainVPC.cidr_block, 1, 0), 1, count.index)
  availability_zone               = data.aws_availability_zones.AZs.names[count.index % 2]
  map_public_ip_on_launch         = false
  tags = {
    Name = join("", [var.DeploymentName, "-Subnet-", tostring(count.index)])
  }
}


resource "aws_route_table" "ARM-Route" {
  vpc_id = aws_vpc.MainVPC.id
  tags = {
    Name = join("", [var.DeploymentName, "-RTable"])
  }
}


resource "aws_route_table_association" "ARM-Association" {
  count          = 2
  subnet_id      = aws_subnet.ARM-Subnets[count.index].id
  route_table_id = aws_route_table.ARM-Route.id
}


output "MainVPC_id" {
  value = aws_vpc.MainVPC.id
}


output "ARMSubnets_id" {
  value = aws_subnet.ARM-Subnets[*].id
}
