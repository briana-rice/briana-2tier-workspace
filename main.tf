module "vpc" {
  source           = "./modules/vpc"
  environment_name = var.environment_name
  aws_region       = var.aws_region
  vpc_cidr         = var.vpc_cidr
}

module "webserver" {
  source            = "./modules/ec2"
  environment_name  = var.environment_name
  aws_region        = var.aws_region
  vpc_id            = module.vpc.vpc_id
  public_subnets    = module.vpc.public_subnets
  key_pair_name     = var.key_pair_name
}

module "rds" {
  source           = "./modules/rds"
  environment_name = var.environment_name
  vpc_id           = module.vpc.vpc_id
  private_subnets  = module.vpc.private_subnets
  web_sg_id        = module.webserver.web_sg_id
  db_name          = var.db_name
  db_username      = var.db_username
  db_password      = var.db_password
}
