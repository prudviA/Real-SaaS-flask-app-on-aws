resource "aws_s3_bucket" "app_bucket" {
  bucket = "SaaS-flask-app-assets"

  tags = {
    Name        = "My bucket"
    
  }
}