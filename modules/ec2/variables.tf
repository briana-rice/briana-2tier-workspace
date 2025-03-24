variable "environment_name" {
  type = string
}

variable "public_subnets" {
  type = list(string)
}

variable "key_pair_name" {
  type = string
}

variable "aws_region" {
  type = string
}

variable "vpc_id" {
  type = string
}