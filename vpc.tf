resource "aws_vpc" "summafy_vpc" {
  cidr_block                       = "10.0.0.0/16"
  enable_dns_support               = true
  enable_dns_hostnames             = true
  tags                             = local.tags
}

## create subnet inside vpc
resource "aws_subnet" "main" {
	vpc_id = aws_vpc.summafy_vpc.id
	cidr_block = "10.0.1.0/24"
	availability_zone = "us-east-1d"
	map_public_ip_on_launch = true
	tags = local.tags
}

## create second subnet inside vpc
resource "aws_subnet" "second" {
	vpc_id = aws_vpc.summafy_vpc.id
	cidr_block = "10.0.2.0/24"
	availability_zone = "us-east-1e"
	map_public_ip_on_launch = true
	tags = local.tags
}

## create second subnet inside vpc
resource "aws_subnet" "private-main" {
	vpc_id = aws_vpc.summafy_vpc.id
	cidr_block = "10.0.3.0/24"
	availability_zone = "us-east-1c"
	map_public_ip_on_launch = false
	tags = {
		Name = format("%s Private Subnet 1", local.tags.Name) 
	}
}

## create second subnet inside vpc
resource "aws_subnet" "private-second" {
	vpc_id = aws_vpc.summafy_vpc.id
	cidr_block = "10.0.4.0/24"
	availability_zone = "us-east-1e"
	map_public_ip_on_launch = false
	tags = {
		Name = format("%s Private Subnet 2", local.tags.Name) 
	}
}

## Add internet gateway for outside access
resource "aws_internet_gateway" "igw" {
	vpc_id = "${aws_vpc.summafy_vpc.id}"
	tags = local.tags
}

## create routing table for external access
resource "aws_route_table" "crt" {
	vpc_id = "${aws_vpc.summafy_vpc.id}"
	route {
		cidr_block = "0.0.0.0/0"
		gateway_id = "${aws_internet_gateway.igw.id}"
	}
	tags = {
		Name = format("My RT : %s", local.tags.Name) 
	}
}

resource "aws_route_table_association" "main" {
  subnet_id      = aws_subnet.main.id
  route_table_id = aws_route_table.crt.id
}

resource "aws_route_table_association" "second" {
  subnet_id      = aws_subnet.second.id
  route_table_id = aws_route_table.crt.id
}

## private route table
resource "aws_route_table" "prvt_rt" {
  vpc_id = "${aws_vpc.summafy_vpc.id}"
  tags = {
	Name = "Private route table"
  }
}

resource "aws_route_table_association" "private-main" {
  subnet_id      = aws_subnet.private-main.id
  route_table_id = aws_route_table.prvt_rt.id
}

resource "aws_route_table_association" "private-second" {
  subnet_id      = aws_subnet.private-second.id
  route_table_id = aws_route_table.prvt_rt.id
}