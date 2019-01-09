# Create a AMP server

resource "aws_instance" "amp" {

#    ignore_changes = ["package-compose-amp-sg"]
    ami = "${var.centos_ami}"
    instance_type = "${var.instance_type}"

    tags {
        Name = "${var.server_names["amp"]}"
        "Application Role" = "compose-amp-server"
       }

    provisioner "file" {
        source = "${var.tf_home}/${var.scripts_file_path}/${var.os}/${var.scripts_file_name["amp"]}"
        destination = "/tmp/${var.scripts_file_name["amp"]}"
        
	connection {
        type = "ssh"
        user = "root"
	private_key = "${file("${var.tf_home}/${var.aws_key_path}")}"
        timeout = "5m"
        agent = false
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
        }
    }


    provisioner "remote-exec" {
        inline = [
	  "chmod +x /tmp/${var.scripts_file_name["amp"]}",
	  "chmod +x /tmp/${var.scripts_file_name["config"]}",
          "sh /tmp/${var.scripts_file_name["amp"]}"
        ]

        connection {
        type = "ssh"
        user = "root"
        private_key = "${file("${var.tf_home}/${var.aws_key_path}")}"
        timeout = "5m"
        agent = false
        }

    }

    security_groups = ["package-compose-amp-sg"]
#    vpc_security_group_ids = ["${var.amp-sg-id}"]
    key_name = "${var.aws_key_name}"
}


output "amp-private-ip"{
	value="${aws_instance.amp.private_ip}"

}

