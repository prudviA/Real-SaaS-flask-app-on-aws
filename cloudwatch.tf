resource "aws_cloudwatch_log_group" "flask_logs" {
  name              = "/aws/ec2/flask-app"
  retention_in_days = 7

  tags = {
    Environment = "production"
    Application = "serviceA"
  }
}
