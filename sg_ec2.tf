resource "aws_security_group" "this" {
  name        = "ark-server-sg"
  description = "Security group for Ark EC2"
  dynamic "ingress" {
    for_each = local.server_sg_ingress

    content {
      from_port       = ingress.value.port
      to_port         = ingress.value.port
      protocol        = ingress.value.protocol
      description     = ingress.value.description
      security_groups = length(ingress.value.security_groups) > 0 ? ingress.value.security_groups : null
      cidr_blocks     = length(ingress.value.cidr_blocks) > 0 ? ingress.value.cidr_blocks : null
    }
  }

  dynamic "egress" {
    for_each = local.server_sg_egress

    content {
      from_port       = egress.value.port
      to_port         = egress.value.port
      protocol        = egress.value.protocol
      description     = egress.value.description
      security_groups = length(egress.value.security_groups) > 0 ? egress.value.security_groups : null
      cidr_blocks     = length(egress.value.cidr_blocks) > 0 ? egress.value.cidr_blocks : null
    }
  }
}
