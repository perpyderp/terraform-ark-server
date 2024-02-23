locals {
  server_sg_ingress = [
    {
      port            = 22
      protocol        = "tcp"
      description     = "Allow ssh into server"
      security_groups = []
      cidr_blocks = [
        var.my_ip
      ]
    },
    {
      port            = 7777
      protocol        = "udp"
      description     = "Allow traffic on game port"
      security_groups = []
      cidr_blocks = [
        var.my_ip
      ]
    },
    {
      port            = 7778
      protocol        = "udp"
      description     = "Peer port"
      security_groups = []
      cidr_blocks = [
        var.my_ip
      ]
    },
    {
      port            = 27015
      protocol        = "udp"
      description     = "Query port"
      security_groups = []
      cidr_blocks = [
        var.my_ip
      ]
    },
    {
      port            = 27020
      protocol        = "tcp"
      description     = "RCONport"
      security_groups = []
      cidr_blocks = [
        var.my_ip
      ]
    }
  ]
  server_sg_egress = [
    {
      port            = 0
      protocol        = "-1"
      description     = "Allow all outbound traffic"
      security_groups = []
      cidr_blocks = [
        "0.0.0.0/0"
      ]
    }
  ]
  app_id = 376030
}
