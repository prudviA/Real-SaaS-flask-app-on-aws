resource "aws_instance" "flask_app" {
  ami           = "ami-0af9569868786b23a"
  instance_type = "t3.micro"
  subnet_id = aws_subnet.flask_public_subnet
  vpc_security_group_ids = [aws_security_group.ec2-sg]
  key_name = "jenkins-server"
  associate_public_ip_address = true
  user_data = file("scripts/flask_setup.sh")

  tags = {
    Name = "Flaskapp"
  }
}
