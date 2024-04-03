
resource "aws_s3_bucket" "terraform-state" {
  bucket = "tfstate-cloudnet-project"

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_s3_bucket_versioning" "terraform-state" {
  bucket = aws_s3_bucket.terraform-state.id

  versioning_configuration {
    status = "Enabled"
  }
}
