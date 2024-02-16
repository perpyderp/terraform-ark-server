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

variable "maps" {
  type        = list(string)
  description = "List of maps created for the Ark cluster"
  default     = ["Ragnarok"]
  validation {
    condition = contains([
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
    ])
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
}

variable "server_sg_egress" {
  type = list(object({
    port            = number
    protocol        = optional(string, "tcp")
    security_groups = optional(list(string), [])
    cidr_blocks     = optional(list(string), [])
    description     = string
  }))
}
