// PROVIDERS
provider "aws" {
  region                  = "us-east-1"
}

data "aws_caller_identity" "current" {}
data "aws_availability_zones" "available" {}


module "vpc" {
  source = "modulesetwork"
}

module "global" {
  source = "moduleslobal"
}

module "letsmigrate-db-sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "letsmigrate-db-sg"
  description = "Security group for letsmigrate-db"
  vpc_id      = module.vpc.vpc_id

  ingress_cidr_blocks      = ["10.0.0.0/16"]
  ingress_rules            = ["https-443-tcp"]
  ingress_with_cidr_blocks = [
    {
      from_port   = 5432
      to_port     = 5432
      protocol    = "tcp"
      description = "PostgreSQL access from within VPC"
      cidr_blocks = module.vpc.vpc_cidr
    },
    {
      from_port   = 8080
      to_port     = 8090
      protocol    = "tcp"
      description = "User-service ports"
      cidr_blocks = "10.0.0.0/16"
    },
    {
      rule        = "postgresql-tcp"
      cidr_blocks = "0.0.0.0/0"
    },
  ]
}

module "db" {
  source = "terraform-aws-modules/rds/aws"

  identifier = "letsmigratedb"

  engine            = "postgres"
  engine_version    = "15.4"
  instance_class    = "db.t3.micro"
  allocated_storage = 20

  db_name  = "letsmigratedb"
  username = "postgres"
  port     = "5432"

  iam_database_authentication_enabled = false
  storage_encrypted= false
  vpc_security_group_ids = [module.letsmigrate-db-sg.security_group_id]

  maintenance_window = "Mon:00:00-Mon:03:00"
  backup_window      = "03:00-06:00"

  tags = {
    Project     = var.stack
    Environment = var.env
    ManagedBy   = "terraform"
    Team        = "myteam"
    Contact     = "myteam@gmail.com"
  }

  # DB subnet group
  create_db_subnet_group = true
  subnet_ids             = module.vpc.database_subnets

  # DB parameter group
  family = "postgres15"

  # DB option group
  major_engine_version = "15.4"

  # Database Deletion Protection
  deletion_protection = true

}