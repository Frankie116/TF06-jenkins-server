# Terraform configuration

module "my_new_ec2" {
  source = "../_modules/ec2"
  my-tag-name = "my-jenkins-server"
}

