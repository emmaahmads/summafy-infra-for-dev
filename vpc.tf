## create a VPC
resource "aws_vpc" "main" {
	cidr_block = "10.0.0.0/16"
	tags = local.tags
	enable_dns_support = true
	enable_dns_hostnames = true
}

## create subnet inside vpc
resource "aws_subnet" "main" {
	vpc_id = aws_vpc.main.id
	cidr_block = "10.0.1.0/24"
	availability_zone = "us-east-1c"
	map_public_ip_on_launch = true
	tags = local.tags
}

## create second subnet inside vpc
resource "aws_subnet" "second" {
	vpc_id = aws_vpc.main.id
	cidr_block = "10.0.2.0/24"
	availability_zone = "us-east-1e"
	map_public_ip_on_launch = true
	tags = local.tags
}

## create second subnet inside vpc
resource "aws_subnet" "private" {
	vpc_id = aws_vpc.main.id
	cidr_block = "10.0.3.0/24"
	availability_zone = "us-east-1c"
	map_public_ip_on_launch = false
	tags = {
		Name = format("%s Private Subnet", local.tags.Name) 
	}
}

## Add internet gateway for outside access
resource "aws_internet_gateway" "igw" {
	vpc_id = "${aws_vpc.main.id}"
	tags = local.tags
}

## create routing table for external access
resource "aws_route_table" "crt" {
	vpc_id = "${aws_vpc.main.id}"
	route {
		cidr_block = "0.0.0.0/0"
		gateway_id = "${aws_internet_gateway.igw.id}"
	}
	tags = local.tags
}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.main.id
  route_table_id = aws_route_table.crt.id
}