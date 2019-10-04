variable "cluster_id" {}

variable "number_cache_nodes" {
  default = 1
}

variable "cluster_node_type" {
  default = "cache.t2.medium"
}

variable "cache_engine" {
  default = "redis"
}

variable "cluster_engine_version" {
  default = "5.0.4"
}

variable "cluster_port" {
  default = 6379
}

variable "cluster_parameter_group_name" {
  default = "default.redis5.0"
}

variable "subnet_ids" {
  default = []
}

variable "subnet_group_name" {}
