resource "aws_vpc" "this" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = "true"
  tags = merge(
    {
      "Name" = format("%s", var.vpc_name)
    },
    var.tags,
  )
}
