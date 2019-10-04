resource "aws_ecr_repository" "this" {
  name                 = "${var.ecr_name}"
  image_tag_mutability = "${var.ecr_image_tag_mutability}"

  tags = "${merge(var.tags)}"
}
