# Output variable definitions

output my_az {
  description = "region of infrastructure"
  value       = [module.my_new_ec2.this_availability_zone]
}


output ec2_public_ip {
  description = "Public IP of EC2 instances"
  value       = module.my_new_ec2.this_public_ip
}


output "this_id" {
  description = "The id of myec2 instance"
  value       = module.my_new_ec2.this_id
}


output "this_private_ip" {
  description = "The private ip on myec2 network interface"
  value       = module.my_new_ec2.this_private_ip
}


output "this_dns" {
  description = "The dns of ENI"
  value       = module.my_new_ec2.this_dns
}