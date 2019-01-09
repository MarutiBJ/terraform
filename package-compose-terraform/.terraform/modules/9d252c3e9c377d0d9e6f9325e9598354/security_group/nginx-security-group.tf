###### Security Group For Nginx Server #################

variable nginx-sg-name {}

resource "aws_security_group" "nginx" {
  name        = "${var.nginx-sg-name}"
  description = "Allow connections to NGINX Server"
  lifecycle {
        ignore_changes = ["package-compose-nginx-sg"]
    }  

  ##SSH access from anywhere

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

   ## HTTP access from anywhere
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


   ##outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }


  tags {
        Name = "${var.nginx-sg-name}"
	"Application Role" = "NGINX security group"
        "Opt out" = "true"
        "Project" = "Package-Compose"
    }
}

##Output

output "nginx-sg-id" {

    value="${aws_security_group.nginx.id}"

}
