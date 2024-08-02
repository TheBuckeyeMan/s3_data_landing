# resource "aws_instance" "example" {
#   ami           = "ami-0c55b159cbfafe1f0"  # Amazon Linux 2 AMI (Change to your desired AMI ID)
#   instance_type = "t2.micro"               # Free tier eligible instance type

#   tags = {
#     Name = "example-instance"
#   }
# }