resource "aws_ec2_transit_gateway_vpc_attachment" "this" {
  subnet_ids         = ["${var.sub_id}"]
  transit_gateway_id = "${var.tgw_id}"
  vpc_id             = "${var.vpc_id}"
}
