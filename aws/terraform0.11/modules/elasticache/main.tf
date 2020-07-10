resource "aws_elasticache_cluster" "this" {
  cluster_id           = "${var.cluster_id}"
  engine               = "${var.cache_engine}"
  node_type            = "${var.cluster_node_type}"
  num_cache_nodes      = "${var.number_cache_nodes}"
  parameter_group_name = "${var.cluster_parameter_group_name}"
  engine_version       = "${var.cluster_engine_version}"
  port                 = "${var.cluster_port}"
  subnet_group_name    = "${aws_elasticache_subnet_group.subnet.name}"
}

resource "aws_elasticache_subnet_group" "subnet" {
  name       = "${var.subnet_group_name}"
  subnet_ids = ["${var.subnet_ids}"]
}
