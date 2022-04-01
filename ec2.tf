# resource "aws_instance" "demo" {
#   ami           = "ami-073998ba87e205747"
#   instance_type = "t2.micro"

#   network_interface {
#     network_interface_id = aws_network_interface.demo-ENI.id
#     device_index         = 0
#   }
#   key_name = aws_key_pair.deployer.id
#   tags = {
#     Name = "HelloWorld"
#   }
# }

# resource "aws_key_pair" "deployer" {
#   key_name   = "id_ed25519.pub"
#   public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHAzSVTR1P7Iu9OjsfGAId52pefxUku6t9vPNhv1i9P0 ws0599@administrator-OptiPlex-3080"
# }

# resource "aws_security_group" "allow_tls" {
#   name        = "allow_tls"
#   description = "Allow TLS inbound traffic"
#   vpc_id      = aws_vpc.main.id

#   tags = {
#     Name = "allow_tls"
#   }
# }

# resource "aws_security_group_rule" "example" {
#   type              = "ingress"
#   from_port         = 22
#   to_port           = 22
#   protocol          = "tcp"
#   cidr_blocks       = ["13.213.52.236/32"]
#   security_group_id = aws_security_group.allow_tls.id
# }

# resource "aws_network_interface" "demo-ENI" {
#   subnet_id       = aws_subnet.subnet1.id
#   private_ips     = ["172.16.0.10"]
#   security_groups = [aws_security_group.allow_tls.id]
#   tags = {
#     Name = "demo-ENI"
#   }
# }


resource "aws_instance" "web" {

  ami           = "ami-0d058fe428540cd89"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.public_a.id

  key_name               = aws_key_pair.dev.key_name
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]

  tags = {
    Name = "frontend_sv"
  }
}
resource "aws_instance" "web" {

  ami           = "ami-0d058fe428540cd89"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.public_a.id

  key_name               = aws_key_pair.dev.key_name
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]

  tags = {
    Name = "backend_sv"
  }
}
# tạo ssh keypair

resource "aws_key_pair" "dev" {
  key_name   = "id_rsa"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDgPGlDZM1v3TqT6R0EutkyToaKpO1/5MnJ6R7i3/7d1o1vkgsIYEdJFXz84DXKnsszZOW4uxLS2Pa69/2PMlpv6do0Gm1DLcRTGjtlBDGuULbb0KQLQDsDx9EPWvafVBfpUV2jWiGDA6xvQAiJFZZBB7PMU2G35VGcnWhjly/zCGP60/hQjHRfM9VAQ5gY2QYuMva7Qiez/rMqT3YYmPIj+SgKba9bX/1QlcRLA/t58LP9awgXm9WnO3xDQq9X0IjNuiqnGXGqgJrMSr9eTJrt2Dv5zfR12IF19cGDTayEueVDaqGYWNcWUEwTcd0UJGIjmtDWZx/CNy9MryZwzOSE+LWsVRb34dg7KVUFu5hyf7BiELl+vMN/sxmActaSA+jNsMVGE+QftJxxd/tInrpcXXcmKAODBgsDTnKIPanVWYUWzjNcnZ41NPt4a/znNUwbHA+6uNP7W93qJ7QTZzd6advZh28tqHC2ITvEeWsvAodNjb6zkzWbD9TIIjvJea0= jenkins@aac6ff4c7aea"
}

# tạo security group allow ssh

resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "SSH from specify IPs"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["113.23.4.109/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# in ra public ip của ec2 instance
output "ec2_instance_public_ips" {
  value = aws_instance.web.*.public_ip
}