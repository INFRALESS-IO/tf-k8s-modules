resource "aws_route53_vpc_association_authorization" "route53_authorization" {
  provider = aws.shared_route53_association
  vpc_id   = var.vpc_id
  zone_id  = var.route53_zone_association_id
}

resource "aws_route53_zone_association" "route53_association" {
  provider = aws.this
  vpc_id   = aws_route53_vpc_association_authorization.route53_authorization.vpc_id
  zone_id  = aws_route53_vpc_association_authorization.route53_authorization.zone_id
}
