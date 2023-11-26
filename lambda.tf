resource "aws_lambda_function" "example" {
  function_name = "my-lambda-function"
  handler      = "index.handler" # Updated handler to reference the exported function in your lambda.js file
  runtime      = "python3.11"
  #filename     = "C:\\Users\\ambis\\ue122-sqs-terraform\\package.sh\\deployment-package.zip"
  filename = "${path.module}/python-lambda.zip"
  role         = aws_iam_role.lambda_exec.arn
  # Other Lambda function configuration
  environment {
    variables = {
      SQS_QUEUE_URL = aws_sqs_queue.my_queue.url
    }
  }
}

resource "aws_iam_role" "lambda_exec" {
  name = "my-lambda-exec-role"
  # Other role configuration

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "attach" {
  policy_arn = aws_iam_policy.lambda_sqs_policy.arn
  role       = aws_iam_role.lambda_exec.name
}
