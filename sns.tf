resource "aws_sns_topic" "budget_alerts" {
  name = "budget_alerts-topic"
}

resource "aws_sns_topic_subscription" "email_alert" {
  topic_arn = aws_sns_topic.budget_alerts.arn
  protocol  = "email"
  endpoint  = "prudhvachuth77299@gmail.com"
}