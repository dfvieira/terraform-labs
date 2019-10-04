resource "aws_network_interface" "this" {
  subnet_id         = "${var.subnet_id}"
  private_ips       = ["${var.eni_private_ip}"]
  source_dest_check = "${var.eni_source_dest_check}"
  tags              = "${merge(map("Name", format("%s", var.eni_name)), var.tags)}"
}
