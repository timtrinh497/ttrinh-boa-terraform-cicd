resource "aws_security_group" "ttrinh_sec-groups" {
  name        = "ttrinh_allow_rules"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = data.aws_vpc.ttrinh-exiting-vpc.id
  
#  ingress {
#    description = "Allow HTTP from anywhere"
#    from_port   = 22
#    to_port     = 22
#    protocol    = "tcp"
#    cidr_blocks = ["0.0.0.0/0"]
#  }

#  ingress {
#    description = "Allow HTTPS from anywhere"
#    from_port   = 80
#    to_port     = 80
#    protocol    = "tcp"
#    cidr_blocks = ["0.0.0.0/0"]
#  }

  tags = {
    Name = "ttrinh_firewall_rules"
  }
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.ttrinh_sec-groups.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

# allow 22 port from everywhere
resource "aws_vpc_security_group_egress_rule" "allow_tls_ipv4" {
  security_group_id = aws_security_group.ttrinh_sec-groups.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port = 22
  ip_protocol       = "tcp"
  to_port = 22
}

# allow 80 port from everywhere
resource "aws_vpc_security_group_egress_rule" "allow_tls_ipv4_http" {
  security_group_id = aws_security_group.ttrinh_sec-groups.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port = 80
  ip_protocol       = "tcp"
  to_port = 80
}