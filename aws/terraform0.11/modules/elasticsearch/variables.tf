variable "domain_name" {}

variable "elasticsearch_version" {}

variable "es_instance_type" {
  default = "t2.small.elasticsearch"
}

variable "es_name" {
  default = ""
}

variable "tags" {
  default = {}
}

variable "subnet_ids" {
  default = []
}

variable "ebs_volume_size" {
  default = 0
}

variable "ebs_volume_type" {
  type    = "string"
  default = "gp2"
}

variable "encrypt_at_rest_enabled" {
  type    = "string"
  default = "true"
}
