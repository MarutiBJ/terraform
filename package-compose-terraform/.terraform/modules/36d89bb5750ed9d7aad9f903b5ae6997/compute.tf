##Pre defined variables
variable "aws_key_path" {}
variable "aws_key_name" {}
variable "aws_region" {}
variable "amp-sg-id" {}
variable "ldap-sg-id" {}
variable "nginx-sg-id" {}
variable "amp-private-ip" {}
variable "nginx-private-ip" {}
variable "ldap-private-ip" {}
variable server_names { type="map" }
variable scripts_file_name { type="map" }
variable scripts_file_path {}
variable tf_home {}
variable os {}
variable centos_ami {}


##Define variables

variable "instance_type" {
  default     = "m3.medium"
  description = "AWS instance type"
}



##Module to create AMP instance
module "compose-amp"{
    source = "./compose-amp"
    centos_ami = "${var.centos_ami}"
    aws_region = "${var.aws_region}"
    instance_type = "${var.instance_type}"
    aws_key_name = "${var.aws_key_name}"
    amp-sg-id ="${var.amp-sg-id}"
    server_names ="${var.server_names}"
    scripts_file_path = "${var.scripts_file_path}"
    scripts_file_name = "${var.scripts_file_name}"
    aws_key_path = "${var.aws_key_path}"
    tf_home = "${var.tf_home}"
    os = "${var.os}"
    amp-private-ip= "${var.amp-private-ip}"
}

##Module to create nginx instance

module "nginx"{
    source = "./nginx"
    centos_ami = "${var.centos_ami}"
    aws_region = "${var.aws_region}"
    instance_type = "${var.instance_type}"
    aws_key_name = "${var.aws_key_name}"
    nginx-sg-id ="${var.nginx-sg-id}"
    server_names ="${var.server_names}"
    scripts_file_path = "${var.scripts_file_path}"
    aws_key_path = "${var.aws_key_path}"
    tf_home = "${var.tf_home}"
    scripts_file_name = "${var.scripts_file_name}"
    os = "${var.os}"
    nginx-private-ip= "${var.nginx-private-ip}"
}


##Module to create ldap instance

module "ldap"{
    source = "./ldap"
    centos_ami = "${var.centos_ami}"
    aws_region = "${var.aws_region}"
    instance_type = "${var.instance_type}"
    aws_key_name = "${var.aws_key_name}"
    ldap-sg-id ="${var.ldap-sg-id}"
    server_names ="${var.server_names}"
    scripts_file_path = "${var.scripts_file_path}"
    aws_key_path = "${var.aws_key_path}"
    tf_home = "${var.tf_home}"
    scripts_file_name = "${var.scripts_file_name}"
    os = "${var.os}"
    ldap-private-ip= "${var.ldap-private-ip}"
}


output "amp-private-ip"{
	value="${module.compose-amp.amp-private-ip}"
}


output "nginx-private-ip"{
	value="${module.nginx.nginx-private-ip}"
}

output "ldap-private-ip"{
	value="${module.ldap.ldap-private-ip}"
}
