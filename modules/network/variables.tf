variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}
variable "stack" {
  type        = string
  description = "Stack Name"
  default     = "letsmigrate"
}
variable "env" {
  type        = string
  description = "Environment"
  default     = "staging"
}
variable "vpc_cidr" {
  type        = string
  description = "VPC CIDR"
  default     = "10.0.0.0/16"
}
variable "azs" {
  type        = list(string)
  description = "AZs for subnets"
  default     = ["us-east-1a", "us-east-1b", "us-east-1c"]
}
variable "public_subnets" {
  type        = list(string)
  description = "Public subnets per AZ"
  default     = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
}
variable "private_subnets" {
  type        = list(string)
  description = "Private subnet per AZ"
  default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}
variable "database_subnets" {
  type        = list(string)
  description = "Subnets for the Database"
  default     = ["10.0.21.0/24", "10.0.22.0/24"]
}

variable "private_subnet_prefix" {
  type        = list(string)
  description = "Private subnet name prefix"
  default     = ["priv-sub-1", "priv-sub-2", "priv-sub-3"]
}

variable "public_subnet_prefix" {
  type        = list(string)
  description = "Public subnet name prefix"
  default     = ["pub-sub-1", "pub-sub-2", "pub-sub-3"]
}

variable "database_subnet_prefix" {
  type        = list(string)
  description = "Database subnet name prefix"
  default     = ["db-sub-1", "db-sub-2"]
}