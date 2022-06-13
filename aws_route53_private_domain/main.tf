# ----------------------------------------

resource "aws_route53_zone" "this" {
  name    = var.domain
  comment = var.description

  vpc {
    vpc_id = var.private_zone
  }

  tags = var.tags

  lifecycle {
    ignore_changes = [vpc]
  }
}
