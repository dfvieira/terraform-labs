resource "aws_ec2_transit_gateway" "this" {
  description = "${var.tgw_description}"

  tags = "${merge(map("Name", format("%s", var.tgw_name)), var.tags)}"
}
