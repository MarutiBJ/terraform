# Create a AMP server

resource "aws_instance" "nginx" {
    
    ami = "${var.centos_ami}"
    instance_type = "${var.instance_type}"

    tags {
        Name = "${var.server_names["nginx"]}"
        "Application Role" = "compose-nginx-server"
       }

    provisioner "file" {
        source = "${var.tf_home}/${var.scripts_file_path}/${var.os}/${var.scripts_file_name["nginx"]}"
        destination = "/tmp/${var.scripts_file_name["nginx"]}"
        
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
	  "chmod +x /tmp/${var.scripts_file_name["nginx"]}",
	  "chmod +x /tmp/${var.scripts_file_name["config"]}",
          "sh /tmp/${var.scripts_file_name["nginx"]}"
        ]

        connection {
        type = "ssh"
        user = "root"
        private_key = "${file("${var.tf_home}/${var.aws_key_path}")}"
        timeout = "5m"
        agent = false
        }

    }

    security_groups = ["package-compose-nginx-sg"]
#    vpc_security_group_ids = ["${var.nginx-sg-id}"]
    key_name = "${var.aws_key_name}"
}

output "nginx-private-ip"{
        value="${aws_instance.nginx.private_ip}"

}

