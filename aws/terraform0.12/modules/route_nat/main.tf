resource "aws_route" "this" {
  route_table_id         = var.rtb_id
  destination_cidr_block = var.dest_cidr_block
  nat_gateway_id         = var.nat_gateway_id
}
