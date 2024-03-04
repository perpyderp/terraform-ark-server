data "aws_region" "current" {}
data "aws_caller_identity" "current" {}

# Get latest Amazon Linux AMI
data "aws_ami" "amazon-linux_2023" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["al2023-ami-2023*-x86_64"]
  }
  # filter {
  #   name   = "virtualization-type"
  #   values = ["hvm"]
  # }
}
# Get latest Amazon Linux 2 AMI
data "aws_ami" "amazon-linux-2" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}
