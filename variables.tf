variable "server_name" {
  type        = string
  description = "Name of the Ark Server"
  default     = "My Ark Server"
}

variable "server_launch_template_userdata_script_name" {
  type        = string
  description = "Name of file for userdata script"
  default     = "server_userdata.sh"
}

variable "ebs_volume_size" {
  type        = number
  description = "Volumne size of your server"
  default     = 20
}

variable "key_name" {
  type        = string
  description = "Name of key pair to SSH into server"
}

variable "server_map" {
  type        = string
  description = "Ark map (level name) to be created"
  default     = "Ragnarok"
  validation {
    condition = can(contains([
      "TheIsland",
      "TheCenter",
      "ScorchedEarth_P",
      "Ragnarok",
      "Aberration_P",
      "Extinction",
      "Valguero_P",
      "Genesis",
      "CrystalIsles",
      "Gen2",
      "LostIsland",
      "Fjordur",
    ], var.server_map))
    error_message = "You must have a valid map (level) name."
  }
}

variable "ports" {
  type = object({
    game_port  = number
    query_port = number
    peer_port  = number
    rcon_port  = number
  })
  description = "Ports to allow game connections, steam to find server, etc."
  default = {
    game_port  = 7777
    peer_port  = 7778
    query_port = 27015
    rcon_port  = 27020
  }
}

variable "server_sg_ingress" {
  type = list(object({
    port            = number
    protocol        = optional(string, "tcp")
    security_groups = optional(list(string), [])
    cidr_blocks     = optional(list(string), [])
    description     = string
  }))
  default = []
}

variable "server_sg_egress" {
  type = list(object({
    port            = number
    protocol        = optional(string, "tcp")
    security_groups = optional(list(string), [])
    cidr_blocks     = optional(list(string), [])
    description     = string
  }))
  default = []
}

variable "instance_type" {
  type        = string
  description = "Type of instance for your server. Use different types for better or less performance"
  default     = "m5.large"
}

variable "my_ip" {
  type        = string
  description = "Your IP address. Used for security groups for server to be accessible to you"
  sensitive   = true
}

variable "server_password" {
  type        = string
  description = "Password of your server"
  sensitive   = true
}

variable "admin_password" {
  type        = string
  description = "Password for admins"
  sensitive   = true
}

variable "max_players" {
  type        = number
  description = "Max number of players allowed in the server"
  default     = 20
}

variable "game_mods" {
  type    = string
  default = ""
}
