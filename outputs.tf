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

output "docker-ip-public" {
	description = "Instance ip, use http://<ip> to connect to docker-engine and ssh ubuntu@<ip> for ssh"
	value = aws_instance.docker-engine.public_ip
}

output "docker-ip-private" {
	description = "Instance ip, use http://<ip> to connect to docker-engine and ssh ubuntu@<ip> for ssh"
	value = aws_instance.docker-engine.private_ip
}

output "rds-endpoint" {
    value = module.database.db_instance_endpoint #aws_db_instance.summafy-database.endpoint
}

# output "dbpswrd" {
# 	value = module.database.master_password
# }