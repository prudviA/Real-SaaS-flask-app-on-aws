resource "aws_db_subnet_group" "default" {
  name       = "saas-db-subnet-group"
  subnet_ids = [aws_subnet.flask_private_subnet_1.id, aws_subnet.flask_private_subnet_2.id ]

  tags = {
    Name = "saas_db_subnet_group"
  }
}
resource "aws_db_instance" "default" {
  allocated_storage    = 20
  db_name              = "mydb"
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t3.micro"
  username             = "Saas"
  password             = "Saas1234"
  parameter_group_name = "default.mysql8.0"
  skip_final_snapshot  = true
  vpc_security_group_ids = [ aws_security_group.rds_sg.id ]
  publicly_accessible = true
  db_subnet_group_name = aws_db_subnet_group.default.name
}
