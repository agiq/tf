output "zone_id" {
  description = "ID of Route53 zone"
  value = aws_route53_zone.this.id
}

output "domain_name" {
  description = "Domain name of Route53 zone"
  value = var.domain_name
}