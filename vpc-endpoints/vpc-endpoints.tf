resource "aws_security_group" "SecurityGroup" {
  name      =  join("", [var.DeploymentName, "-SG"])
  description = "S3 GW Endpoint Security Group"
  vpc_id      = var.VPC_ID
  ingress = [
    {
      description      = "https traffic"
      from_port        = 443
      to_port          = 443
      protocol         = "tcp"
      cidr_blocks      = [var.VPC_CIDR]
      ipv6_cidr_blocks = ["::1/128"]
      prefix_list_ids = []
      security_groups = []
      self = false
    }
  ]
  egress = [
    {
      description      = "Default rule"
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::1/128"]
      prefix_list_ids = []
      security_groups = []
      self = false
    }
  ]
  }


  resource "aws_vpc_endpoint" "s3-int-endpoint" {
    vpc_id            = var.VPC_ID
    service_name = join("", ["com.amazonaws." ,data.aws_region.current.name, ".s3"])
    vpc_endpoint_type = "Interface"
    security_group_ids = [aws_security_group.SecurityGroup.id]
    subnet_ids = var.SubnetsID
    policy = data.template_file.endpoint-policy.rendered
    tags = {
      Name = join("", [var.DeploymentName, "-s3-endpoint"])
    }
  }


  output "Endpoint_DNS" {
    value = aws_vpc_endpoint.s3-int-endpoint.dns_entry
  }
