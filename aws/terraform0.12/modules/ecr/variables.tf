variable "ecr_name" {
  default = "dev-repo"
}

variable "image_tag_mutability" {
  default = "MUTABLE"
}

variable "tags" {
  default = {}
}

variable "scan_on_push" {
  default = true
}

