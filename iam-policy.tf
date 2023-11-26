resource "aws_iam_policy" "lambda_sqs_policy" {
  name        = "LambdaSQSPolicy"
  description = "IAM policy for Lambda to interact with SQS"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = [
          "sqs:SendMessage",
          "sqs:ReceiveMessage",
          "sqs:DeleteMessage"
        ],
        Effect = "Allow",
        Resource = aws_sqs_queue.my_queue.arn
      },
      {
        Action = "sqs:GetQueueUrl",
        Effect = "Allow",
        Resource = aws_sqs_queue.my_queue.arn
      }
    ]
  })
}
