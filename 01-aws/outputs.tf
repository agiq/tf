output "vpc_ip" {
  description = "ID of VPC"
  value = aws_vpc.main.id
}

output "test_vm_private_addresses" {
  value = aws_instance.test_vm[*].private_ip
}

output "prod_vm_private_addresses" {
  value = aws_instance.prod_vm[*].private_ip
}

output "prod_vm_public_addresses" {
  value = aws_instance.test_vm[*].public_ip
}