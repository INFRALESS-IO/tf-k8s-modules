output "zone_id" {
  value       = aws_route53_zone.this.zone_id
  description = "The Hosted Zone ID"
}

output "name_servers" {
  value       = aws_route53_zone.this.name_servers
  description = "A list of name servers in associated delegation set"
}
