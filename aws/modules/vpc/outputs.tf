output "vpc_id" {
  value = "${aws_vpc.this.id}"
}

output "rtb_id" {
  value = "${aws_vpc.this.default_route_table_id}"
}
