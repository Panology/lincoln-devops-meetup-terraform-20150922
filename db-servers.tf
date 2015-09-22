resource "aws_db_instance" "meetup-db" {
    identifier = "meetup-example-default-vpc-rds"
    allocated_storage = 10
    engine = "mysql"
    engine_version = "5.6.23"
    instance_class = "db.t2.micro"
    name = "mydb"
    username = "mydbuser"
    password = "insecure!"
    /*db_subnet_group_name = "my_database_subnet_group"*/
    parameter_group_name = "default.mysql5.6"
    vpc_security_group_ids = ["${aws_security_group.db.id}"]
    db_subnet_group_name = "meetup-db-subnet-group"

}
