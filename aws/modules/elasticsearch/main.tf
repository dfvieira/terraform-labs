resource "aws_elasticsearch_domain" "this" {
  domain_name           = "${var.domain_name}"
  elasticsearch_version = "${var.elasticsearch_version}"

  ebs_options {
    ebs_enabled = "${var.ebs_volume_size > 0 ? true : false}"
    volume_size = "${var.ebs_volume_size}"
    volume_type = "${var.ebs_volume_type}"
  }

  cluster_config {
    instance_type = "${var.es_instance_type}"
  }

  vpc_options {
    subnet_ids = ["${var.subnet_ids}"]
  }

  tags = "${merge(map("Name", format("%s", var.es_name)), var.tags)}"
}
