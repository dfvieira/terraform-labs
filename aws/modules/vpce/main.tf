resource "aws_vpc_endpoint" "this" {
  vpc_id            = "${var.vpc_id}"
  service_name      = "${var.endpoint_service_name}"
  vpc_endpoint_type = "${var.endpoint_type}"
  route_table_ids   = ["${var.route_table_id}"]
}
