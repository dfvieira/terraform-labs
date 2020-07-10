resource "aws_eip" "this" {
  vpc = true

  tags = merge(
    {
      "Name" = format("%s", var.name)
    },
    var.tags,
  )
}
