variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}
variable "sse_algorithm" {
  description = "Encryption Algorithm"
  type        = string
  default     = "aws:kms"
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

variable "production-s3" {
  type        = string
  description = "Production s3"
  default     = "letsmigrate-production-s3"
}

variable "legacy-s3" {
  type        = string
  description = "Legacy s3"
  default     = "letsmigrate-legacy-s3"
}

