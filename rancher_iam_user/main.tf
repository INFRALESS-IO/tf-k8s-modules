# -----------------------

resource "aws_iam_user" "this" {
  name                 = local.iam.name
  path                 = local.iam.path
  force_destroy        = local.iam.force_destroy
  permissions_boundary = local.iam.permissions_boundary
  tags                 = local.iam.tags
}

resource "aws_iam_access_key" "this_no_pgp" {
  user = aws_iam_user.this.name
}

resource "aws_iam_policy" "this" {
  name        = local.iam.policy.name
  path        = local.iam.policy.path
  description = local.iam.policy.description
  policy      = local.iam.policy.policy
}

resource "aws_iam_user_policy_attachment" "this" {
  user       = aws_iam_user.this.name
  policy_arn = aws_iam_policy.this.arn
}
