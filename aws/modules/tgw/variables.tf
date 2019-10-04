variable "tgw_description" {
  default = "Transit Gateway created by terraform"
}

variable "tgw_name" {}

variable "tags" {
  description = "A map of tags to add to all resources"
  default     = {}
}
