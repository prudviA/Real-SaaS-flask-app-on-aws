resource "aws_instance" "node_app" {
  ami                         = "ami-0af9569868786b23a"
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.flask_public_subnet.id
  vpc_security_group_ids      = [aws_security_group.ec2-sg.id]
  key_name                    = "saas-key"
  associate_public_ip_address = true


  tags = {
    Name = "nodeapp"
  }


  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file("/home/ubuntu/saas-key.pem")
    host        = self.public_ip
  }

  provisioner "file" {
    source      = "/home/ubuntu/Real-SaaS-flask-app-on-aws/app/index.js"
    destination = "/home/ec2-user/index.js"
  }

  provisioner "file" {
    source      = "/home/ubuntu/Real-SaaS-flask-app-on-aws/app/index.html"
    destination = "/home/ec2-user/index.html"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo yum update -y",
      "curl -fsSL https://rpm.nodesource.com/setup_18.x | sudo bash -",
      "sudo yum install -y nodejs",
      "sudo npm install -g pm2",
      "cd /home/ec2-user",
      "pm2 start index.js",
      "pm2 startup systemd",
      "pm2 save"
    ]
  }
}
