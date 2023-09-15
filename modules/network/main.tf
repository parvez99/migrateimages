data "aws_region" "current" {}
locals {
  azs                   = formatlist("${data.aws_region.current.name}%s", ["a", "b", "c"])
  private_subnet_names  = split(";", trim(join("", flatten([for k, v in var.private_subnet_prefix : [for a, b in local.azs : "${v}-${b};"]])), ";"))
  public_subnet_names   = split(";", trim(join("", flatten([for k, v in var.public_subnet_prefix : [for a, b in local.azs : "${v}-${b};"]])), ";"))
  database_subnet_names = split(";", trim(join("", flatten([for k, v in var.database_subnet_prefix : [for a, b in local.azs : "${v}-${b};"]])), ";"))
}

module "vpc" {
  source  = "registry.terraform.io/terraform-aws-modules/vpc/aws"
  version = "5.1.0"

  name = "${var.stack}-${var.env}"
  cidr = var.vpc_cidr

  azs = local.azs

  # Currently using Single NAT Gateway for all subnets to keep costs down, can be changed in the future!
  enable_nat_gateway     = true
  single_nat_gateway     = true
  one_nat_gateway_per_az = false
  create_igw             = true

  private_subnets      = var.private_subnets
  private_subnet_names = local.private_subnet_names
  public_subnets       = var.public_subnets
  public_subnet_names  = local.public_subnet_names
  database_subnets      = var.database_subnets
  database_subnet_names = local.database_subnet_names

  tags = {
    Project     = var.stack
    Environment = var.env
    ManagedBy   = "terraform"
    Team        = "myteam"
    Contact     = "myteam@gmail.com"
  }
}