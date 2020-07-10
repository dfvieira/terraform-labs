resource "aws_s3_bucket" "this" {
  bucket = var.s3_name
  acl    = var.s3_acl

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  versioning {
    enabled = var.s3_versioning
  }

  tags = merge(var.tags)
}

resource "aws_s3_bucket_policy" "this" {
  bucket = aws_s3_bucket.this.id

  policy = var.s3_policy 
  
}