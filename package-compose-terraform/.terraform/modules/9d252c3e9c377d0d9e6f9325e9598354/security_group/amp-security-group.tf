###### Security Group For AMP Server #################

variable amp-sg-name {}

resource "aws_security_group" "amp" {
  name        = "${var.amp-sg-name}"
  description = "Allow connections to AMP Server"
  lifecycle {
        ignore_changes = ["package-compose-amp-sg"]
    }  



   ##SSH access from anywhere
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


   ##HTTP access from anywhere
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ##AMP access from anywhere
  ingress {
    from_port   = 8081
    to_port     = 8081
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
        Name = "${var.amp-sg-name}"
	"Application Role" = "AMP security group"
        "Opt out" = "true"
        "Project" = "Package-Compose"
    }
}


##Output

output "amp-sg-id" {

    value="${aws_security_group.amp.id}"

}
