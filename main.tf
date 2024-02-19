resource "aws_vpc" "vpcdemo1232" {
  cidr_block = var.cidr_vpc

}

resource "aws_subnet" "sub" {
  vpc_id = aws_vpc.vpcdemo1232.id
  cidr_block = var.cidr_vpc
  availability_zone = var.az
  map_public_ip_on_launch = true
}

resource "aws_internet_gateway" "itg" {
  vpc_id = aws_vpc.vpcdemo1232.id
}

resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.vpcdemo1232.id
  route  {
    cidr_block = var.cidr_rt
    gateway_id = aws_internet_gateway.itg.id
  }
}

resource "aws_route_table_association" "rta" {
  subnet_id = aws_subnet.sub.id
  route_table_id = aws_route_table.rt.id
}

resource "aws_security_group" "sg" {
  name = "sg"
  vpc_id = aws_vpc.vpcdemo1232.id

  ingress  {
    description = "Allow TLS"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }

  ingress {
    description = "Allow SSH"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }

  ingress {
    description = "Allow HTTP"
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks =["0.0.0.0/0"] 
  }
}

resource "aws_instance" "instance" {
  ami = var.ami_id
  instance_type = var.instance_type
  vpc_security_group_ids = [aws_security_group.sg.id]
  subnet_id = aws_subnet.sub.id
}