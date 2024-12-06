output "cli-id" {
	value = aws_instance.cli-host.arn
}

output "cli-ip" {
	description = "Instance ip, use http://<ip> to connect to cli-host and ssh ubuntu@<ip> for ssh"
	value = aws_instance.cli-host.public_ip
}

output "docker-id" {
	value = aws_instance.docker-engine.arn
}

output "docker-ip" {
	description = "Instance ip, use http://<ip> to connect to docker-engine and ssh ubuntu@<ip> for ssh"
	value = aws_instance.docker-engine.public_ip
}