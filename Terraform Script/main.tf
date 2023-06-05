provider "aws" {
  region = "ap-south-1" # I am using asia pacific (mumbai) region as my EC2 instance and s3 bucket are running on the mumbai region
}

resource "aws_lambda_function" "spring_boot_lambda" {
  function_name = "spring-boot-lambda"
  role          = aws_iam_role.lambda_execution_role.arn
  handler       = "com.example.Application::handleRequest"
  runtime       = "java17"

  filename      = "path/to/your/deployment.jar"
}

resource "aws_iam_role" "lambda_execution_role" {
  name = "spring-boot-lambda-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}