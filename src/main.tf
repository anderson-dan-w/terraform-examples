variable "server_port" {
  description = "The port the server will use for HTTP requests"
default = 8080
}

provider "aws" {
  region = "us-west-2"
}


resource "aws_security_group" "http-sg" {
  name = "dan-tf-http-sg-2"
  ingress {
    from_port = "${var.server_port}"
    to_port = "${var.server_port}"
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "dan-tf" {
  ami = "ami-005bdb005fb00e791"
  instance_type = "t2.micro"
  vpc_security_group_ids = ["${aws_security_group.http-sg.id}"]

  user_data = <<-EOF
              #!/bin/bash
              echo "Hello, World" > index.html
              nohup busybox httpd -f -p "${var.server_port}" &
              EOF

  tags = {
    Name = "dan-tf-example"
  }
}
