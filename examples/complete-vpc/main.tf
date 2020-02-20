provider "aws" {
  region = "us-east-1"
}

data "aws_security_group" "default" {
  name   = "default"
  vpc_id = module.vpc.vpc_id
}

module "vpc" {
  source = "../../"

  name = "eks-vpc"

  cidr = "10.0.0.0/16"

  azs                 = ["us-east-1a", "us-east-1b"]
  private_subnets     = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets      = ["10.0.3.0/24", "10.0.4.0/24"]

  create_database_subnet_group = false

  enable_dns_hostnames = true
  enable_dns_support   = true

  # enable_classiclink             = true
  # enable_classiclink_dns_support = true

  enable_nat_gateway = true
  single_nat_gateway = true

  enable_vpn_gateway = false

  # enable_dhcp_options              = true
  # dhcp_options_domain_name         = "service.consul"
  # dhcp_options_domain_name_servers = ["127.0.0.1", "10.10.0.2"]

  # VPC endpoint for S3
  enable_s3_endpoint = false

  # VPC endpoint for DynamoDB
  enable_dynamodb_endpoint = false

  # VPC endpoint for SSM
  enable_ssm_endpoint              = false
  ssm_endpoint_private_dns_enabled = false
  ssm_endpoint_security_group_ids  = [data.aws_security_group.default.id]

  # VPC endpoint for SSMMESSAGES
  enable_ssmmessages_endpoint              = false
  ssmmessages_endpoint_private_dns_enabled = false
  ssmmessages_endpoint_security_group_ids  = [data.aws_security_group.default.id]

  # VPC Endpoint for EC2
  enable_ec2_endpoint              = false
  ec2_endpoint_private_dns_enabled = false
  ec2_endpoint_security_group_ids  = [data.aws_security_group.default.id]

  # VPC Endpoint for EC2MESSAGES
  enable_ec2messages_endpoint              = false
  ec2messages_endpoint_private_dns_enabled = false
  ec2messages_endpoint_security_group_ids  = [data.aws_security_group.default.id]

  # VPC Endpoint for ECR API
  enable_ecr_api_endpoint              = false
  ecr_api_endpoint_private_dns_enabled = false
  ecr_api_endpoint_security_group_ids  = [data.aws_security_group.default.id]

  # VPC Endpoint for ECR DKR
  enable_ecr_dkr_endpoint              = false
  ecr_dkr_endpoint_private_dns_enabled = false
  ecr_dkr_endpoint_security_group_ids  = [data.aws_security_group.default.id]

  # VPC endpoint for KMS
  enable_kms_endpoint              = false
  kms_endpoint_private_dns_enabled = false
  kms_endpoint_security_group_ids  = [data.aws_security_group.default.id]

  # VPC endpoint for ECS
  enable_ecs_endpoint              = false
  ecs_endpoint_private_dns_enabled = false
  ecs_endpoint_security_group_ids  = [data.aws_security_group.default.id]

  # VPC endpoint for ECS telemetry
  enable_ecs_telemetry_endpoint              = false
  ecs_telemetry_endpoint_private_dns_enabled = false
  ecs_telemetry_endpoint_security_group_ids  = [data.aws_security_group.default.id]

  # VPC endpoint for SQS
  enable_sqs_endpoint              = false
  sqs_endpoint_private_dns_enabled = false
  sqs_endpoint_security_group_ids  = [data.aws_security_group.default.id]

  tags = {
    Owner       = "user"
    Environment = "eks"
    Name        = "eks-cluster-network"
  }

  vpc_endpoint_tags = {
    Project  = "Secret"
    Endpoint = "true"
  }
}

