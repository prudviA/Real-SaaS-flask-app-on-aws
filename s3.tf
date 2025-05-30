resource "aws_s3_bucket" "app_bucket" {
  bucket = "saas-flask-app-assets"

  tags = {
    Name        = "My bucket"
    
  }
}
