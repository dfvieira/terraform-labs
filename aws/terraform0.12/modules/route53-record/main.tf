resource "aws_route53_record" "this" {
  zone_id = var.zone_id
  name    = var.target_domain
  type    = "CNAME"
  ttl     = "300"
  records = [var.source_domain]
}
