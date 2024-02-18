resource "aws_launch_template" "this" {

  name                   = var.server_name
  update_default_version = true
  description            = "Game server launch template"

  instance_type = var.instance_type

  image_id = data.aws_ami.amazon-linux_2023.id

  network_interfaces {
    associate_public_ip_address = true
    security_groups = [
      aws_security_group.this.id
    ]
  }

  capacity_reservation_specification {
    capacity_reservation_preference = "none"
  }

  credit_specification {
    cpu_credits = "standard"
  }

  disable_api_stop        = false
  disable_api_termination = false
  ebs_optimized           = false

  key_name = var.key_name

  block_device_mappings {
    device_name = "/dev/xvda"
    ebs {
      volume_size = 25
      volume_type = "gp3"
    }
  }

  user_data = var.server_launch_template_userdata_script_name == null ? null : filebase64("${path.root}/scripts/${var.server_launch_template_userdata_script_name}")

}
