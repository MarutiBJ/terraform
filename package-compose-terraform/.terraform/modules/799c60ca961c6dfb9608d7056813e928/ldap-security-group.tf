###### Security Group For LDAP Server #################

variable ldap-sg-name {}

resource "aws_security_group" "ldap" {
  name        = "${var.ldap-sg-name}"
  description = "Allow connections to LDAP Server"
  lifecycle {
        ignore_changes = ["package-compose-ldap-sg"]
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

   ##LDAP access from anywhere
  ingress {
    from_port   = 389
    to_port     = 389
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
        Name = "${var.ldap-sg-name}"
	"Application Role" = "LDAP security group"
        "Opt out" = "true"
        "Project" = "Package-Compose"
    }
}

##Output

output "ldap-sg-id" {

    value="${aws_security_group.ldap.id}"

}
