# ----
# DATA
# ----

data "aws_subnet_ids" "web_subnets" {
  vpc_id = local.vpc.id
  tags = {
    Scheme = local.vpc.public_subnets
  }
}
