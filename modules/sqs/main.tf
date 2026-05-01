resource "aws_sqs_queue" "main" {
  name                      = "image-processor-${var.env}-queue"
  visibility_timeout_seconds = 360
  message_retention_seconds  = 86400

  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.dlq.arn
    maxReceiveCount     = 3
  })

  tags = {
    Name = "sqs-${var.env}"
  }
}

resource "aws_sqs_queue" "dlq" {
  name = "image-processor-${var.env}-dlq"

  message_retention_seconds = 1209600

  tags = {
    Name = "sqs-dlq-${var.env}"
  }
}