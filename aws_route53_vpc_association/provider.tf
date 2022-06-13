terraform {
  required_providers {
    aws = {
      source                = "hashicorp/aws"
      version               = "~> 3.37"
      configuration_aliases = [aws.shared_route53_association, aws.this]
    }
  }
}
