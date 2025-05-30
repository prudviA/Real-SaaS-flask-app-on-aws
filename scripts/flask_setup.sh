#!/bin/bash
yum update -y
yum install -y python3 git
pip3 install flask

cat <<EOF > /home/ec2-user/app.py
from flask import Flask
app = Flask(__name__)
@app.route('/')
def home():
    return "Hello from Flask SaaS App!"
app.run(host="0.0.0.0", port=80)
EOF

nohup python3 /home/ec2-user/app.py > /home/ec2-user/app.log 2>&1 &