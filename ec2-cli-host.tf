/*data "aws_ami" "cli-host" {
	most_recent = true
	filter {
		name = "name"
		values = ["cli-host-image"]
	}
	owners = ["975050042748"] # emmaahmads
}*/

# create an instance
resource "aws_instance" "cli-host" {
	ami = "ami-0e2c8caa4b6378d8c" #data.aws_ami.cli-host.id
	instance_type = "t2.micro"
        key_name = "cli-host"
	iam_instance_profile = "cli-host"
         user_data = file("${path.module}/files/install_cli.sh")
	tags = {
		Name = format("cli-host %s", local.tags.Name) 
	}
	subnet_id = aws_subnet.main.id
	vpc_security_group_ids = [aws_security_group.summafy-cli-host.id]
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
resource "aws_security_group" "summafy-cli-host" {
	vpc_id = aws_vpc.summafy_vpc.id
	name = "allow cli-host instance connection"
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
