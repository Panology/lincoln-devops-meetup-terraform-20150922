/* Default security group */
resource "aws_security_group" "default" {
  name = "default-meetup-example"
  description = "Default security group that allows inbound and outbound traffic from all instances in the VPC"
  vpc_id = "${aws_vpc.default.id}"

  ingress {
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    self        = true
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
}

  tags {
    Name = "meetup-example-default-vpc"
  }
}


/* Security group for the nat server */
resource "aws_security_group" "nat" {
  name = "nat-meetup-example"
  description = "Security group for nat instances that allows SSH and VPN traffic from internet"
  vpc_id = "${aws_vpc.default.id}"

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 1194
    to_port   = 1194
    protocol  = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
}

  tags {
    Name = "nat-meetup-example"
  }
}

/* Security group for the web */
resource "aws_security_group" "web" {
  name = "web-meetup-example"
  description = "Security group for web that allows web traffic from internet"
  vpc_id = "${aws_vpc.default.id}"

  ingress {
    from_port = 80
    to_port   = 80
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 443
    to_port   = 443
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "web-meetup-example"
  }
}

/* Security group for the db */
resource "aws_security_group" "db" {
  name = "db-meetup-example"
  description = "Security group for db that allows traffic from app servers"
  vpc_id = "${aws_vpc.default.id}"

  ingress {
    from_port = 3306
    to_port   = 3306
    protocol  = "tcp"
    security_groups = ["${aws_security_group.web.id}"]
  }

  tags {
    Name = "db-meetup-example"
  }
}
