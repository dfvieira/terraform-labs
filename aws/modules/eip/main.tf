resource "aws_eip" "eip-checkpoint" {
  vpc               = true
  network_interface = "${var.eip_net_interface}"

  #Assossiar a IP privado especifico da ENI
  #associate_with_private_ip = "${var.private_ip}"

  tags = "${merge(map("Name", format("%s", var.eip_name)), var.tags)}"
}
