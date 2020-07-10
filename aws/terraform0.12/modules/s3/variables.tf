variable "s3_name" {
}

variable "s3_acl" {
  default = "private"
}

variable "s3_versioning" {
  default = false
}

variable "tags" {
  default = {}
}

variable "s3_policy" {
  default = <<POLICY
{
  "Version": "2012-10-17",
  "Id": "this_policy",
  "Statement": [
    {
      "Sid": "IPAllow",
      "Effect": "Deny",
      "Principal": "*",
      "Action": "s3:*",
      "Resource": "arn:aws:s3:::this/*",
      "Condition": {
         "IpAddress": {"aws:SourceIp": "0.0.0.0/0"}
      }
    }
  ]
}
POLICY
}