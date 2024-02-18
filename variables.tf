variable "server_name" {
  type        = string
  description = "Name of the Ark Server"
  default     = "My Ark Server"
}

variable "server_launch_template_userdata_script_name" {
  type        = string
  description = "Name of file for userdata script"
  default     = null
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

variable "map" {
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
    ], var.map))
    error_message = "You must have a valid map (level) name."
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
}
