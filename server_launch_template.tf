resource "aws_launch_template" "name" {

  name                   = var.server_name
  update_default_version = true
  description            = "Game server launch template"

  user_data = var.server_launch_template_userdata_script_name == null ? null : filebase64("${path.root}/scripts/${var.server_launch_template_userdata_script_name}")

}
