resource "aws_network_interface_attachment" "this" {
  instance_id          = "${var.instance_id}"
  network_interface_id = "${var.network_interface_id}"
  device_index         = 1
}
