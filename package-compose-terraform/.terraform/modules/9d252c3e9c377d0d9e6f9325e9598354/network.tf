##Pre defined Variables
variable "aws_key_path" {}
variable "aws_key_name" {}
variable "aws_region" {}
variable "server_names" { type="map" } 
variable scripts_file_name { type="map" }
variable scripts_file_path { } 
variable tf_home {}



variable "amp-sg-name" {
    description = "Name for amp security group"
    default = "package-compose-amp-sg"
}

variable "nginx-sg-name" {
    description = "Name for nginx security group"
    default = "package-compose-nginx-sg"
}

variable "ldap-sg-name" {
    description = "Name for ldap security group"
    default = "package-compose-ldap-sg"
}

##Module to create security group for nexus and nginx machines
module "sg"{
  source = "./security_group"
  amp-sg-name = "${var.amp-sg-name}"
  ldap-sg-name = "${var.ldap-sg-name}"
  nginx-sg-name = "${var.nginx-sg-name}"

}

##Outputs
output "amp-sg-id"{
	value="${module.sg.amp-sg-id}"
}

output "ldap-sg-id"{
	value="${module.sg.ldap-sg-id}"
}

output "nginx-sg-id"{
	value="${module.sg.nginx-sg-id}"
}
