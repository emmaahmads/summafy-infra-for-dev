# Get user_data for instance provision
# data "template_file" "wordpress_user_data" {
# 	template = "${file("${path.module}/files/install_docker.sh")}"
# 	# vars = {
# 	# 	# db_user = local.user
# 	# 	# db_password = module.database.db_instance_password
# 	# 	# db_endpoint = module.database.db_instance_address
# 	# 	# db_name = local.database
# 	# }
# }

data "aws_ami" "docker-host" {
	most_recent = true
	filter {
		name = "name"
		values = ["docker-host image 2"]
	}
	owners = ["975050042748"] # emmaahmads
}
 
# create an instance
resource "aws_instance" "docker-engine" {
	ami = data.aws_ami.docker-host.id
	instance_type = "t2.micro"
    key_name = "docker-engine"
 #   user_data = file("${path.module}/files/install_docker.sh")
	tags = {
		Name = format("docker-host %s", local.tags.Name) 
	}
	subnet_id = aws_subnet.main.id
	vpc_security_group_ids = [aws_security_group.summafy-docker-engine.id]
	associate_public_ip_address = true
	lifecycle {
		ignore_changes = [
	# Ignore changes to tags, e.g. because a management agent
	# updates these based on some ruleset managed elsewhere.
			ami,
		]
	}
}

# create security group for aws access
resource "aws_security_group" "summafy-docker-engine" {
	vpc_id = aws_vpc.main.id
	name = "allow docker-engine instance connection"
	ingress {
		description = "HTTP from Everywhere"
		from_port = 80
		to_port = 80
		protocol = "tcp"
		cidr_blocks = ["0.0.0.0/0"]
	}
	ingress {
		description = "ssh from Everywhere"
		from_port = 22
		to_port = 22
		protocol = "tcp"
		cidr_blocks = ["0.0.0.0/0"]
	}
	egress {
		from_port = 0
		to_port = 0
		protocol = "-1"
		cidr_blocks = ["0.0.0.0/0"]
		ipv6_cidr_blocks = ["::/0"]
	}
	tags = local.tags
}

# resource "aws_security_group_rule" "ec2_to_db" {
# 	type = "ingress"
# 	from_port = 514
# }