##Run time variable
variable "tf_home" {
    description = "Path where main.tf is present"
    default = "/home/compose/package-compose-terraform"
} 

##AWS Key path.
##Add the key name here
variable "aws_key_path" {
    description = "Pem key file name"
    default ="auth/aws/dev-aws/dont-delete-package-compose.pem"
}

##AWS default region 
variable "aws_region" {
    description = "Region"
    #default = "eu-west-1"   #Ireland
}


variable "centos_ami" {
    description = "AMI As per the region"
    #default = "ami-4ac6653d"
}


##Names of machines to appear on AWS console
variable "server_names" {
    description = "Names for machines"
    type="map"
    default = {
	amp="compose-amp",
	ldap="ldap",
	nginx="nginx"
   	
 }
}

##Target OS for the instances
variable "os" {
	default = "centos"
}


variable "scripts_file_name" {
    description = "Path to script file"
    type="map"
    default = {
	amp="amp-conf.sh",
    	nginx="nginx-conf.sh",
	ldap="ldap-conf.sh",
	config="config.sh"
 }
}

##Path for the scripts to be run afte instances are provisioned
variable "scripts_file_path" {
	default = "prereq-scripts"
}


