/* DB subnet */
resource "aws_subnet" "db1" {
  vpc_id            = "${aws_vpc.default.id}"
  cidr_block        = "${var.db1_subnet_cidr}"
  availability_zone = "us-west-1b"
  map_public_ip_on_launch = false
  tags {
    Name = "db1"
  }
}

resource "aws_subnet" "db2" {
  vpc_id            = "${aws_vpc.default.id}"
  cidr_block        = "${var.db2_subnet_cidr}"
  availability_zone = "us-west-1c"
  map_public_ip_on_launch = false
  tags {
    Name = "db2"
  }
}

resource "aws_db_subnet_group" "meetup-db" {
    name = "meetup-db-subnet-group"
    description = "Our main group of subnets"
    subnet_ids = ["${aws_subnet.db1.id}","${aws_subnet.db2.id}"]
}
