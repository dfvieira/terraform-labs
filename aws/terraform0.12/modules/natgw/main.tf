resource "aws_nat_gateway" "this" {
  allocation_id = var.eip_id
  subnet_id     = var.subnet_id
  tags = merge(
    {
      "Name" = format("%s", var.name)
    },
    var.tags,
  )
}
