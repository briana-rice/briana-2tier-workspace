terraform {
  required_version = ">= 1.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "remote" {
    organization = "1LUIT"
    workspaces {
      name = "briana-2tier-workspace"
    }
  }
}

provider "aws" {
  region = var.aws_region
}
