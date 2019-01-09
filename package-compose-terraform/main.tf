##AWS Credentials
variable "aws_access_key" {}
variable "aws_secret_key" {}

##AWS key name in region
variable "aws_key_name" {}


##Configuring AWS default credentials
module "providers" {
  source = "./providers/aws/dev"
  aws_access_key = "${var.aws_access_key}"
  aws_secret_key = "${var.aws_secret_key}"  
}


##Add region to the provider
provider "aws" {
	region = "${var.aws_region}"
}


##Create network for the infrastructure
module "network" {
  source = "./modules/aws/network"
  aws_region = "${var.aws_region}"
  aws_key_path = "${var.aws_key_path}"
  aws_key_name = "${var.aws_key_name}"
  server_names = "${var.server_names}" 
  scripts_file_path = "${var.scripts_file_path}"
  scripts_file_name = "${var.scripts_file_name}" 
  tf_home = "${var.tf_home}"
}

##Create instances for the infrastructure
module "compute" {
  source = "./modules/aws/compute"
  centos_ami = "${var.centos_ami}"
  aws_region = "${var.aws_region}"
  aws_key_path = "${var.aws_key_path}"
  aws_key_name = "${var.aws_key_name}"
  server_names = "${var.server_names}" 
  amp-sg-id = "${module.network.amp-sg-id}"
  ldap-sg-id = "${module.network.ldap-sg-id}"
  nginx-sg-id = "${module.network.nginx-sg-id}"
  scripts_file_path = "${var.scripts_file_path}"
  scripts_file_name = "${var.scripts_file_name}"
  tf_home = "${var.tf_home}"
  os = "${var.os}"
  amp-private-ip = "${module.compute.amp-private-ip}"
  ldap-private-ip = "${module.compute.ldap-private-ip}"
  nginx-private-ip = "${module.compute.nginx-private-ip}"
}

output "compose-amp-security-group-id"{
	value="${module.network.amp-sg-id}"
}

output "ldap-security-group-id"{
	value="${module.network.ldap-sg-id}"
}

output "nginx-security-group-id"{
	value="${module.network.nginx-sg-id}"
}

output "compose-amp-private-ip"{
	value="${module.compute.amp-private-ip}"
}

output "ldap-private-ip"{
	value="${module.compute.ldap-private-ip}"
}

output "nginx-private-ip"{
	value="${module.compute.nginx-private-ip}"
}
