
data "aws_ami" "ubuntu" {

  most_recent = true

  owners = ["099720109477"]

  filter {
    name = "name"

    values = [
      "ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"
    ]
  }
}

resource "aws_instance" "webserver" {

  ami = data.aws_ami.ubuntu.id

  instance_type = var.instance_type

  vpc_security_group_ids = [
    var.security_group_id
  ]

  key_name = var.key_name

  user_data = <<-EOF
              #!/bin/bash
              apt update -y
              apt install nginx -y
              systemctl enable nginx
              systemctl start nginx
              echo "<h1>Terraform Deployed Website</h1>" > /var/www/html/index.html
              EOF

  tags = {
    Name = "terraform-webserver"
  }
}
