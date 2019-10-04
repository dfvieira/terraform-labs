variable "eni_name" {
  default = ""
}

variable "tags" {
  default = {}
}

variable "eni_private_ip" {
  default = []
}

variable "subnet_id" {
  default = ""
}

variable "eni_source_dest_check" {
  default = "true"
}
