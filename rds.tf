# # add rds database as module
# module "database" {
# 	source = "terraform-aws-modules/rds/aws"
# 	version = ">= 5.6.0, < 6.0.0"
# 	identifier = "codio-database"
# 	engine = "mysql"
# 	allocated_storage = 5
# 	instance_class = "db.t3.micro"
# 	db_name = local.database
# 	username = local.user
# 	port = "3306"
# 	major_engine_version = "8.0"
# 	family = "mysql8.0"
# 	create_db_subnet_group = true
# 	subnet_ids = [aws_subnet.main.id,
# 	aws_subnet.second.id]
# 	vpc_security_group_ids = [aws_security_group.database.id]
# 	apply_immediately = true
# 	skip_final_snapshot = true
# 	deletion_protection = false
# 	tags = local.tags
# }

# # create security group for database access
# resource "aws_security_group" "database" {
# 	vpc_id = aws_vpc.main.id
# 	name = "allow database connection"
# 	ingress {
# 		description = "Mysql from VPC"
# 		from_port = 3306
# 		to_port = 3306
# 		protocol = "tcp"
# 		cidr_blocks = [aws_subnet.main.cidr_block,aws_subnet.second.cidr_block]
# 	}
# 	egress {
# 		from_port = 0
# 		to_port = 0
# 		protocol = "-1"
# 		cidr_blocks = ["0.0.0.0/0"]
# 		ipv6_cidr_blocks = ["::/0"]
# 	}
# 	tags = local.tags
# }
