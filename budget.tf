resource "aws_budgets_budget" "monthly" {
  name              = "budget-monthly"
  budget_type       = "COST"
  limit_amount      = "10"
  limit_unit        = "USD"
  time_period_start = "2025-06-01"
  time_unit         = "MONTHLY"

  cost_filter {
    name = "Service"
    values = [
      "Amazon Elastic Compute Cloud - Compute",
    ]
  }

  notification {
    comparison_operator        = "GREATER_THAN"
    threshold                  = 75
    threshold_type             = "PERCENTAGE"
    notification_type          = "ACTUAL"
    subscriber_email_addresses = ["prudhviachuth77299@gmail.com"]
    subscriber_sns_topic_arns = [aws_sns_topic.budget_alerts.arn]
  }
}