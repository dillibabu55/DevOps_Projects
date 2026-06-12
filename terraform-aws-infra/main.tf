module "security_group" {
  source = "./modules/security-group"
}

module "keypair" {
  source          = "./modules/keypair"
  public_key_path = var.public_key_path
}

module "ec2" {
  source            = "./modules/ec2"
  instance_type     = var.instance_type
  security_group_id = module.security_group.sg_id
  key_name          = module.keypair.key_name
}
