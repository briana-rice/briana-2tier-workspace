variable "aws_region" {
  type        = string
  description = "AWS region to deploy resources"
  default     = "us-east-1"
}

variable "key_pair_name" {
  type        = string
  description = "Existing key pair for SSH into EC2"
  default     = "LUIT_KEYSBriana"
}

variable "environment_name" {
  type        = string
  description = "Name for tagging and resource naming"
  default     = "briana-env"
}

variable "vpc_cidr" {
  type        = string
  description = "CIDR block for the VPC"
  default     = "10.0.0.0/16"
}

variable "db_name" {
  type        = string
  description = "Name of the MySQL database"
  default     = "briana_db"
}

variable "db_username" {
  type        = string
  description = "Database username"
  default     = "briana_user"
}

variable "db_password" {
  type        = string
  description = "Database password"
  default     = "Purple123"
}
