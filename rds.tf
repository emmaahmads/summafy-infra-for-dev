# add rds database as module
module "database" {
	source = "terraform-aws-modules/rds/aws"
	version = ">= 5.6.0, < 6.0.0"
	identifier = "summafy-database"
	engine = "postgres"
    engine_version    = "17"
	allocated_storage = 5
	instance_class = "db.t3.micro"
  #  template = "free_tier"
	db_name = "summafy"
	username = "summafy_user"
	password = "happyboys123"
	port     = "5432"
	family = "postgres17"
	create_db_subnet_group = true
	subnet_ids = [aws_subnet.private-main.id,
	aws_subnet.private-second.id]
	vpc_security_group_ids = [aws_security_group.database.id]
	apply_immediately = true
	skip_final_snapshot = true
	deletion_protection = false
	enabled_cloudwatch_logs_exports = ["postgresql", "upgrade"]
    create_cloudwatch_log_group     = true
	tags = local.tags
}

# create security group for database access
resource "aws_security_group" "database" {
	vpc_id = aws_vpc.summafy_vpc.id
	name = "allow database connection"
	ingress {
		description = "Postgres from cli-host and docker-engine"
		from_port = 5432
		to_port = 5432
		protocol = "tcp"
		security_groups = [aws_security_group.summafy-docker-engine.id, aws_security_group.summafy-cli-host.id]
	}
	tags = local.tags
}
