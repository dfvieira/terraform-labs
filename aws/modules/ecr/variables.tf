variable "ecr_name" {
  default = "dev-repo"
}

variable "ecr_image_tag_mutability" {
  default = "MUTABLE"
}

variable "tags" {
  default = {}
}
