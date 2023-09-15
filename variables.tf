variable "allowed_account_ids" {
  description = "List of allowed AWS account ids where resources can be created"
  type        = list(string)
  default     = ["249324333018"]
}

variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "stack" {
  type        = string
  description = "Stack Name"
  default     = "lets-migrate"
}
variable "env" {
  type        = string
  description = "Environment"
  default     = "staging"
}
variable "azs" {
  type        = list(string)
  description = "AZs for subnets"
  default     = ["us-east-1a", "us-east-1b", "us-east-1c"]
}
variable "database_subnets" {
  type        = list(string)
  description = "Subnets for the Database"
  default     = ["10.0.21.0/24", "10.0.22.0/24"]
}
variable "database_subnet_prefix" {
  type        = list(string)
  description = "Database subnet name prefix"
  default     = ["db-sub-1", "db-sub-2"]
}

### Shared values

## VPC

variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
  default     = "us-east-1"
}

variable "vpc_cidr" {
  description = "VPC CIDR"
  default       = "10.0.0.0/16"
}