# Create a LDAP server

resource "aws_instance" "ldap" {
    
    ami = "${var.centos_ami}"
    instance_type = "${var.instance_type}"

    tags {
        Name = "${var.server_names["ldap"]}"
        "Application Role" = "ldap-server"
       }

    provisioner "file" {
        source = "${var.tf_home}/${var.scripts_file_path}/${var.os}/${var.scripts_file_name["ldap"]}"
        destination = "/tmp/${var.scripts_file_name["ldap"]}"
        
	connection {
        type = "ssh"
        user = "root"
	private_key = "${file("${var.tf_home}/${var.aws_key_path}")}"
        timeout = "5m"
        agent = false
#	ignore_errors: yes
        }
    }

    provisioner "file" {
        source = "${var.tf_home}/${var.scripts_file_path}/${var.os}/${var.scripts_file_name["config"]}"
        destination = "/tmp/${var.scripts_file_name["config"]}"
        connection {
        type = "ssh"
        user = "root"
        private_key = "${file("${var.tf_home}/${var.aws_key_path}")}"
        timeout = "5m"
        agent = false
#	ignore_errors: yes
        }
    }


    provisioner "remote-exec" {
        inline = [
	  "chmod +x /tmp/${var.scripts_file_name["ldap"]}",
	  "chmod +x /tmp/${var.scripts_file_name["config"]}",
          "sh /tmp/${var.scripts_file_name["ldap"]}"
        ]

        connection {
        type = "ssh"
        user = "root"
        private_key = "${file("${var.tf_home}/${var.aws_key_path}")}"
        timeout = "5m"
        agent = false
        }

    }

    security_groups = ["package-compose-ldap-sg"]
#    vpc_security_group_ids = ["${var.ldap-sg-id}"]
    key_name = "${var.aws_key_name}"
}

output "ldap-private-ip"{
        value="${aws_instance.ldap.private_ip}"

}

