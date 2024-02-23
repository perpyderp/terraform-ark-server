resource "aws_launch_template" "this" {

  name                   = var.server_name
  update_default_version = true
  description            = "Game server launch template"

  instance_type = var.instance_type

  image_id = data.aws_ami.amazon-linux-2.id

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
      volume_size = 20
      volume_type = "gp3"
    }
  }

  user_data = base64encode(templatefile("${path.root}/scripts/${var.server_launch_template_userdata_script_name}", {
    SERVER_NAME     = var.server_name
    SERVER_PASSWORD = var.server_password
    ADMIN_PASSWORD  = var.admin_password
    MAX_PLAYERS     = var.max_players
    SERVER_MAP      = var.server_map
  }))

}

# export SERVER_NAME=${var.server_name}
# export SERVER_PASSWORD=${var.server_password}
# export ADMIN_PASSWORD=${var.admin_password}
# export MAX_PLAYERS=${var.max_players}
# export SERVER_MAP=${var.map}
