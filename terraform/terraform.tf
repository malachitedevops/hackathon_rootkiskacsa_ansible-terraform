provider "aws" {
	profile = var.aws_profile
	region = var.aws_region
}

resource "aws_instance" "erste_ec2" {
	ami = var.ec2_ami
	instance_type = var.ec2_instance_type
	key_name = var.key_name 
	security_groups = [var.ec2_security_group]
	tags = {
		Name = var.ec2_name
	}
	provisioner "remote-exec" {
		inline = ["echo 'SSH OK'"]
		connection {
			type = "ssh"
			host = self.public_ip
			user = var.ec2_user
			private_key = file(var.private_key)
		}
	}
	provisioner "local-exec" {
		command = "sed -i '/webservers/a ${self.public_ip}' ${var.hosts_path}" 
	}
	provisioner "local-exec" {
		command = "sed -i 's/.*backend.*/backend_ip: http:\\/\\/${self.public_ip}/' ${var.var_path}"
	}
	provisioner "local-exec" {
		command = "ansible-playbook -i ${var.hosts_path} --private-key ${var.private_key} ${var.ec2_inv_path}"
	}
}

resource "aws_instance" "erste_elastic" {
	ami = var.ec2_ami
	instance_type = var.ec2_instance_type
	key_name = var.key_name
	security_groups = [var.ec2_security_group]
	tags = {
		Name = var.monitoring_ec2_name
	}
	provisioner "remote-exec" {
		inline = ["echo 'SSH OK'"]
		connection {
			type = "ssh"
			host = self.public_ip
			user = var.ec2_user
			private_key = file(var.private_key)
		}
	}
	provisioner "local-exec" {
		command = "sed -i '/elk_server/a ${self.public_ip}' ${var.hosts_path}"
	}
	provisioner "local-exec" {
		command = "ansible-playbook -i ${var.hosts_path} --private-key ${var.private_key} ${var.elastic_inv_path}"
	}
}

resource "aws_db_instance" "erste_db" {
  allocated_storage    = 20
	max_allocated_storage = 40
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "5.7"
	tags = {
		Name = var.db_name
	}
  instance_class       = var.db_instance_type
  name                 = var.db_name
  username             = var.db_user
  password             = var.db_pass
	storage_encrypted = true
}

output "ec2_ip" {
	value = aws_instance.erste_ec2.public_ip
}

output "elastic_ip" {
	value = aws_instance.erste_elastic.public_ip
}
