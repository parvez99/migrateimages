terraform {
  required_version = ">= 1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
  }

  backend "s3" {
    bucket  = "lets-migrate-terraform-backend"
    key     = "state/terraform.tfstate"
    region  = "us-east-1"
    encrypt = true
    # TODO - Enable state locking for consistency
    #dynamodb_table = "migrate-terraform-backend"
  }
}