# #Remember, we had to create an IAM role with full lambda permissions thats on the IAM page

# # Create the Lambda function
# resource "aws_lambda_function" "adam-lambda-for-springbootapp" {
#   function_name = "adam-lambda-for-springbootapp"
#   role          = aws_iam_role.lambda_role.arn
#   handler       = "com.example.demo.HelloWorldHandler::handleRequest"
#   runtime       = "java11"  # or "java8"

#   filename         = "/Users/adammaas/Desktop/Java_Springboot/SpringBootApp/target/SpringArtifact-0.0.1-SNAPSHOT.jar" #Update this with whatever jar executable file you want to run in the lambda function
#   source_code_hash = filebase64sha256("/Users/adammaas/Desktop/Java_Springboot/SpringBootApp/target/SpringArtifact-0.0.1-SNAPSHOT.jar") #Update with the name of the jar executable
# }