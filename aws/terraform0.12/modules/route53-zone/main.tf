resource "aws_route53_zone" "this" {
  name = var.domain

  tags = merge(var.tags)
}
