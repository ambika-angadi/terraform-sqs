resource "aws_sqs_queue" "dead_letter_queue" {
  name = "my-dead-letter-queue"
  # Other configuration options for your dead-letter queue
}

resource "aws_sqs_queue" "my_queue" {
  name                      = "my-queue"
  delay_seconds             = 0
  message_retention_seconds = 86400
  max_message_size          = 262144
  receive_wait_time_seconds = 0
  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.dead_letter_queue.arn,
    maxReceiveCount = 3
  })
}
