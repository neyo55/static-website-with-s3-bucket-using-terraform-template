# AWS S3 bucket resource

resource "aws_s3_bucket" "my_bucket" {
  bucket = var.my_bucket_name # Name of the S3 bucket
}


resource "aws_s3_bucket_ownership_controls" "my_bucket_ownership_controls" {
  bucket = aws_s3_bucket.my_bucket.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}


resource "aws_s3_bucket_public_access_block" "my_bucket_public_access_block" {
  bucket = aws_s3_bucket.my_bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}


# AWS S3 bucket ACL resource
resource "aws_s3_bucket_acl" "my_bucket_acl" {
  depends_on = [
    aws_s3_bucket_ownership_controls.my_bucket_ownership_controls,
    aws_s3_bucket_public_access_block.my_bucket_public_access_block,
  ]

  bucket = aws_s3_bucket.my_bucket.id
  acl    = "public-read"
}

resource "aws_s3_bucket_versioning" "my_bucket_versioning" {
  bucket = aws_s3_bucket.my_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_policy" "my_bucket_policy" {
  bucket =  aws_s3_bucket.my_bucket.id # ID of the S3 bucket

  # Policy JSON for allowing public read access
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : "*",
        "Action" : "s3:GetObject",
        "Resource": "arn:aws:s3:::${var.my_bucket_name}/*"
      }
    ]
  })
}


module "template_files" {
    source = "hashicorp/dir/template"

    base_dir = "${path.module}/web-files"
}

# https://registry.terraform.io/modules/hashicorp/dir/template/latest


resource "aws_s3_bucket_website_configuration" "web-config" {
  bucket =    aws_s3_bucket.my_bucket.id  # ID of the S3 bucket

  # Configuration for the index document
  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}


# AWS S3 object resource for hosting bucket files
resource "aws_s3_object" "Bucket_files" {
  bucket =  aws_s3_bucket.my_bucket.id  # ID of the S3 bucket

  for_each     = module.template_files.files
  key          = each.key
  content_type = each.value.content_type

  source  = each.value.source_path
  content = each.value.content

  # ETag of the S3 object
  etag = each.value.digests.md5
}

