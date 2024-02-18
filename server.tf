resource "aws_instance" "server" {

  launch_template {
    id = aws_launch_template.this.id
  }

}
